package com.fuhousefinder.filter;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 *
 * @author Hanh
 */
public class Authorize implements Filter {

    private static final boolean debug = true;

    private FilterConfig filterConfig = null;

    public Authorize() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("Authorize:DoBeforeProcessing");
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("Authorize:DoAfterProcessing");
        }
    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            Cookie[] cookies = httpRequest.getCookies();
            if (cookies != null) {
                for (Cookie cooky : cookies) {
                    if (cooky.getName().equals("email")) {
                        loginWithCookie(cooky.getValue(), httpRequest);
                    }
                }
            }
        }

        String url = httpRequest.getRequestURI();
        //System.out.println(url);
        if (user == null) {
            if (guestAccess(url)) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendRedirect("/HFManagementSystem/home");
            }
        } else {
            switch (user.getRoleId()) {
                case 1:
                    if (adminAccess(url)) {
                        chain.doFilter(request, response);
                    } else {
                        httpResponse.sendRedirect("/HFManagementSystem/home");
                    }   break;
                case 2:
                    if(landlordAccess(url)){
                        chain.doFilter(request, response);
                    }else {
                        httpResponse.sendRedirect("/HFManagementSystem/home");
                    }   break;
                default:
                    if(tenantAccess(url)){
                        chain.doFilter(request, response);
                    }else {
                        httpResponse.sendRedirect("/HFManagementSystem/home");
                    }   break;
            }
        }

//        chain.doFilter(request, response);

    }

    private boolean guestAccess(String url) {
        return url.contains("home")
                || url.contains("view_house")
                || url.contains("detail_house")
                || url.contains("search_houses")
                || url.contains("login")
                || url.contains("register")
                || url.contains("resetpassword")
                || url.contains("checkgmail")
                || url.contains("img")
                || url.contains("css")
                || url.contains("js")
                || url.contains("fonts")
                || url.contains("api")
                || url.contains("ViewDetailProfile")
                || url.contains("view-report")
                || url.contains("introduction.jsp")
                || url.contains("Send-report");
    }

    private boolean adminAccess(String url) {
        return userLoginAccess(url)
                || url.contains("dashboard")
                || url.contains("manage")
                || url.contains("transaction")
                || url.contains("Sendreplay");
    }

    private boolean userLoginAccess(String url){
        return guestAccess(url)
                || url.contains("Profile")
                || url.contains("change")
                || url.contains("editprofile")
                || url.contains("uploadavatar")
                || url.contains("logout")
                || url.contains("verify");
        
    }
    
    private boolean tenantAccess(String url){
        return userLoginAccess(url)
                || url.contains("history-report")
                || url.contains("historyorder")
                || url.contains("favorite")
                || url.contains("listBlogPosts")
                || url.contains("Booking")
                || url.contains("toggleFavorite");
    }
    
    private boolean landlordAccess(String url){
        return userLoginAccess(url)
                || url.contains("Booking")
                || url.contains("view_landrord")
                || url.contains("view_landrord_detail")
                || url.contains("feedback-landrords")
                || url.contains("upgrade")
                || url.contains("vnpayajax")
                || url.contains("result")
                || url.contains("history-report")
                || url.contains("historytransaction")
                || url.contains("addhouse")
                || url.contains("update_house")
                || url.contains("feedback-landrords")
                || url.contains("add_room")
                || url.contains("check_room_number")
                || url.contains("updatestatushouse")
                || url.contains("updateRoomStatus")
                || url.contains("update_room")
                || url.contains("deleteRoom")
                || url.contains("deleteHouse")
                || url.contains("reply_feedback");
    }
    
    private void loginWithCookie(String emailMd5, HttpServletRequest request) {
        IUser dao = new UserDAO();
        User userLogin;
        HttpSession session = request.getSession();
        Profile p;
        String email = dao.getEmailByMd5(emailMd5);
        if (email != null) {
            userLogin = dao.getUserByEmail(email);
            if (userLogin != null) {
                p = dao.getProfile(userLogin.getId(), userLogin.getRoleId());
                session.setAttribute("user", userLogin);
                session.setAttribute("profile", p);
                //System.out.println("ok");
            }
        }
    }

    /**
     *
     * @return
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    @Override
    public void destroy() {
    }

    @Override
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("Authorize:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("Authorize()");
        }
        StringBuffer sb = new StringBuffer("Authorize(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
