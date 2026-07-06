package com.fuhousefinder.controller.room;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "Booking", urlPatterns = {"/Booking"})
public class Booking extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            OrderDAO orderDAO = new OrderDAO();
            IUser usDAO = new UserDAO();
            String service = request.getParameter("service");
            if (service == null) {
                service = "ViewProfile";
            }
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("/pages/system/login.jsp");
                return;
            }
            switch (service) {
                case "ViewListOrderHistory": {
                    com.fuhousefinder.entity.Profile p = (com.fuhousefinder.entity.Profile) session.getAttribute("profile");
                    int tenantID = usDAO.getTenantIDByUserID(user.getId());
                    String orderStatus = request.getParameter("status");
                    //System.out.println("Order Status " + orderStatus);
                    if (orderStatus == null) {
                        orderStatus = "";
                    }
                    List<BookingOrderModel> ordersByTenant = orderDAO.getAllOrdersByTenantID(tenantID, orderStatus);
                    request.setAttribute("orders", ordersByTenant);
                    request.setAttribute("status", orderStatus);
                    session.setAttribute("profile", p);
                    request.getRequestDispatcher("pages/house/order_history.jsp").forward(request, response);
                    break;
                }
                case "ViewRequestBooking": {
                    com.fuhousefinder.entity.Profile p = (com.fuhousefinder.entity.Profile) session.getAttribute("profile");
                    int landlordId = usDAO.getLandlordByUserID(user.getId());
                    String orderStatus = request.getParameter("status");
                    if (orderStatus == null) {
                        orderStatus = "";
                    }
                    List<BookingOrderModel> ordersByTenant = orderDAO.getAllOrdersToLandLordIDAndStatus(landlordId, orderStatus);
                    request.setAttribute("orders", ordersByTenant);
                    session.setAttribute("profile", p);
                    request.setAttribute("status", orderStatus);
                    request.getRequestDispatcher("pages/house/request_booking.jsp").forward(request, response);
                    break;
                }
                case "CancelBookRoom": {
                    com.fuhousefinder.entity.Profile p = (com.fuhousefinder.entity.Profile) session.getAttribute("profile");
                    String orderStatus = request.getParameter("status");
                    int roomID = Integer.valueOf(request.getParameter("roomId"));
                    int tenantID = usDAO.getTenantIDByUserID(user.getId());
                    int rowUpdated = orderDAO.CancelBookRoom(roomID, tenantID);
                    if (rowUpdated > 0) {
                        request.setAttribute("alertMessage", "Hủy đặt phòng thành công");
                        request.setAttribute("alertType", "success");

                        // cập nhật trạng vào history_order......
                        int orderId = orderDAO.getIDOrder(tenantID, roomID);
                        orderDAO.addHistoryOrder(orderId, "Cancel");

                    } else {
                        request.setAttribute("alertMessage", "Hủy đặt phòng không thành công");
                        request.setAttribute("alertType", "error");
                    }
                    if (orderStatus == null) {
                        orderStatus = "";
                    }
                    List<BookingOrderModel> ordersByTenant = orderDAO.getAllOrdersByTenantID(tenantID, orderStatus);
                    request.setAttribute("orders", ordersByTenant);
                    session.setAttribute("profile", p);
                    request.getRequestDispatcher("/pages/house/order_history.jsp").forward(request, response);
                    break;

                }

                case "AcceptRequestBooking": {
                    com.fuhousefinder.entity.Profile p = (com.fuhousefinder.entity.Profile) session.getAttribute("profile");
                    int landlordId = usDAO.getLandlordByUserID(user.getId());
                    String note = request.getParameter("note");
                    if (note == null) {
                        note = "";
                    }
                    //System.out.println("Run roi");
                    int orderId = Integer.valueOf(request.getParameter("orderId"));
                    int roomId = Integer.valueOf(request.getParameter("roomId"));

                    RoomDao roomdao = new RoomDao();
                    boolean isValid = roomdao.getStatusRoom(roomId);
                    if (isValid) {
                        int rowUpdated = orderDAO.AccecptBookRoom(note, orderId, roomId);
                        if (rowUpdated > 0) {
                            session.setAttribute("alertMessage", "Chấp nhận thuê thành công");
                            session.setAttribute("alertType", "success");
                            // cập nhật vào history_booking
                            orderDAO.addHistoryOrder(orderId, "Approve");
                        }
                    } else {
                        session.setAttribute("alertMessage", "Phòng này đã được cho thuê");
                        session.setAttribute("alertType", "error");
                    }

                    String orderStatus = request.getParameter("status");
                    if (orderStatus == null) {
                        orderStatus = "";
                    }
                    List<BookingOrderModel> ordersByTenant = orderDAO.getAllOrdersToLandLordIDAndStatus(landlordId, orderStatus);
                    request.setAttribute("orders", ordersByTenant);
                    session.setAttribute("profile", p);
                    request.getRequestDispatcher("pages/house/request_booking.jsp").forward(request, response);
                    break;

                }

                case "RejectRequestBooking": {
                    com.fuhousefinder.entity.Profile p = (com.fuhousefinder.entity.Profile) session.getAttribute("profile");
                    int landlordId = usDAO.getLandlordByUserID(user.getId());
                    int orderId = Integer.valueOf(request.getParameter("orderId"));
                    String note = request.getParameter("note");
                    if (note == null) {
                        note = "";
                    }
                    int rowUpdated = orderDAO.RejectBookRoom(note, orderId);
                    if (rowUpdated > 0) {
                        request.setAttribute("alertMessage", "RejectBookRoom thành công");
                        request.setAttribute("alertType", "success");

                        // cập nhật
                        orderDAO.addHistoryOrder(orderId, "Reject");

                    } else {
                        request.setAttribute("alertMessage", "RejectBookRoom không thành công");
                        request.setAttribute("alertType", "error");
                    }
                    String orderStatus = request.getParameter("status");
                    if (orderStatus == null) {
                        orderStatus = "";
                    }
                    List<BookingOrderModel> ordersByTenant = orderDAO.getAllOrdersToLandLordIDAndStatus(landlordId, orderStatus);
                    request.setAttribute("orders", ordersByTenant);
                    session.setAttribute("profile", p);
                    request.getRequestDispatcher("pages/house/request_booking.jsp").forward(request, response);
                    break;

                }
                case "ReturnRoom":
                    int roomID = Integer.valueOf(request.getParameter("roomId"));
                    int orderID = Integer.valueOf(request.getParameter("orderId"));
                    String orderStatus = request.getParameter("status");
                    int tenantID = usDAO.getTenantIDByUserID(user.getId());
                    orderDAO.returnRoom(roomID, tenantID, orderID);

                    List<BookingOrderModel> ordersByTenant = orderDAO.getAllOrdersByTenantID(tenantID, orderStatus);
                    session.setAttribute("alertMessage", "Hệ thống xác nhận rằng bạn đã chuyển đi khỏi phòng đã thuê");
                    session.setAttribute("alertType", "success");

                    // cập nhật vào history_order
                    orderDAO.addHistoryOrder(orderID, "CheckOut");

                    request.setAttribute("orders", ordersByTenant);
                    request.getRequestDispatcher("/Booking?service=ViewListOrderHistory").forward(request, response);
                    break;
                case "confirm":
                    RoomDao roomdao = new RoomDao();
                    int roomId = Integer.valueOf(request.getParameter("roomId"));
                    roomdao.updateRoomStatus(roomId, 1 + "");

                    int tenantId = Integer.valueOf(request.getParameter("tenantId"));
                    
                    roomdao.landlordConfirm(roomId, tenantId,1);
                    request.getRequestDispatcher("/Booking?service=ViewRequestBooking").forward(request, response);
                    break;
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
