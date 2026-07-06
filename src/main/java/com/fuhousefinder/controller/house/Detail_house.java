package com.fuhousefinder.controller.house;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;

@WebServlet(name = "Detail_house", urlPatterns = {"/detail_house"})
public class Detail_house extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            IUser userDAO = new UserDAO();
            OrderDAO orderDAO = new OrderDAO();
            String service = request.getParameter("service");
            HttpSession session = request.getSession();
            if (service == null) {
                service = "ViewHouseDetail";
            }
            switch (service) {
                case "ViewHouseDetail": {
                    try {
                        String idParam = request.getParameter("id");
                        IHousIe dao = new HouseDao();
                        HouseModel hm = dao.getHouseById(idParam);
                        List<RoomModel> rooms = dao.getRoomsByHouseId(idParam);
                        List<HouseImages> houseImages = dao.getHouseImagesByHouseId(idParam);

                        request.setAttribute("list", hm);
                        request.setAttribute("houseImages", houseImages);

                        request.setAttribute("rooms", rooms);

                        User userLogin = (User) session.getAttribute("user");
                        User user = userDAO.getByAllId(String.valueOf(idParam));

                        request.setAttribute("user", user);
                        session.setAttribute("userLogin", userLogin);
                        request.setAttribute("houseID", idParam);
                        if (!response.isCommitted()) {
                            request.getRequestDispatcher("/pages/house/detail_house.jsp").forward(request, response);
                        }
                    } catch (ServletException | IOException e) {
                        response.sendRedirect("pages/error/error500.jsp");
                    }
                }
                break;
                case "BookHouse": {
                    User user = (User) session.getAttribute("user");
                    if (user != null) {
                        if (user.getRoleId() == 3) {
                            //System.out.println(user.getId());
                            int tenantID = userDAO.getTenantIDByUserID(user.getId());
                            int roomID = Integer.parseInt(request.getParameter("roomID"));

                            // lấy những order không bị hủy
                            List<Order> roomsBookedByTenant = orderDAO.getOrderByTenantID(tenantID);
                            request.setAttribute("bookedRooms", roomsBookedByTenant);

                            // kiểm tra đã book phòng chưa
                            boolean alreadyBooked = false;
                            for (Order bookedRoom : roomsBookedByTenant) {
                                String bookingStatus = bookedRoom.getStatus();
                                // doan nay check neu status == dong y hoac dang o trang thai pending thi k cho phep book tiep
                                if ((bookedRoom.getRoomID() == roomID)
                                        && (bookingStatus.equals("Approve") || bookingStatus.equals("Pending"))) {
                                    alreadyBooked = true;
                                    break;
                                }
                            }
                            if (alreadyBooked) {
                                request.setAttribute("alertMessage", "Bạn đã đặt phòng này rồi.");
                                request.setAttribute("alertType", "error");
                            } else {
                                int landlordID = Integer.parseInt(request.getParameter("landlordID"));
                                // lấy các order đã bị hủy
                                List<Order> orderCancel = orderDAO.getOrderCancelByTenantID(tenantID);
                                boolean isCancle = false;
                                int orderIdCancle = 0;
                                for (Order order : orderCancel) {
                                    // nếu phòng đã bị hủy trước đó
                                    if (order.getRoomID() == roomID) {
                                        isCancle = true;
                                        orderIdCancle = order.getOrderID();
                                    }
                                }
                                //System.out.println(isCancle +"  "+orderIdCancle);
                                if (!isCancle) {
                                    int rowsUpdated = orderDAO.bookRoom(tenantID, landlordID, roomID, null);
                                    if (rowsUpdated > 0) {
                                        request.setAttribute("alertMessage", "Đặt phòng thành công.");
                                        request.setAttribute("alertType", "success");
                                        
                                        // tạo thêm bảng history_order( history_id, time, trạng thái, orderId,...)
                                        // thêm chi tiết vào bảng history_order ( thời gian, trạng thái, order_id)
                                        int orderId = orderDAO.getIDOrder(tenantID,roomID);
                                        orderDAO.addHistoryOrder(orderId, "Pending");
                                        
                                    } else {
                                        request.setAttribute("alertMessage", "Đặt phòng không thành công.");
                                        request.setAttribute("alertType", "error");
                                    }
                                } else {
                                    int rowsUpdated = orderDAO.bookAgain(orderIdCancle);
                                    if (rowsUpdated > 0) {
                                        request.setAttribute("alertMessage", "Đặt phòng thành công.");
                                        request.setAttribute("alertType", "success");
                                        orderDAO.addHistoryOrder(orderIdCancle, "Pending");
                                        
                                    } else {
                                        request.setAttribute("alertMessage", "Đặt phòng không thành công.");
                                        request.setAttribute("alertType", "error");
                                    }
                                }

                            }
                            request.getRequestDispatcher("home.jsp").forward(request, response);
                        }
                    } else {
                        response.sendRedirect("pages/system/login.jsp");
                    }
                }
                break;

            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            
            String idParam = request.getParameter("id");

            IHousIe dao = new HouseDao();
            HouseModel hm = dao.getHouseById(idParam);
            List<RoomModel> rooms = dao.getRoomsByHouseId(idParam);
            List<HouseImages> houseImages = dao.getHouseImagesByHouseId(idParam);
            HttpSession session = request.getSession();

            request.setAttribute("list", hm);
            request.setAttribute("houseImages", houseImages);
            session.setAttribute("houseId", idParam);
            request.setAttribute("rooms", pagination(request, rooms, page));

            UserDAO userDAO = new UserDAO();
            User userLogin = (User) session.getAttribute("user");
            User user = userDAO.getByAllId(String.valueOf(idParam));
            LocationModer houseLocation = dao.getLocationModerById(hm.getLocation_id());
            request.setAttribute("maphouse", houseLocation);
            request.setAttribute("user", user);
            if (!response.isCommitted()) {
                request.getRequestDispatcher("/pages/house/detail_house.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    private List<RoomModel> pagination(HttpServletRequest request, List<RoomModel> list, int page) {
        int recordsPerPage = 3;
        int totalRecords = list.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        return list.subList(startIndex, endIndex);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
