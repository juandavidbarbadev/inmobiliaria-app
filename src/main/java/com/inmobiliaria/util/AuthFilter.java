package com.inmobiliaria.util;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("usuario") != null);
        if (!loggedIn) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        } else {
            chain.doFilter(req, res);
        }
    }
    public void init(FilterConfig config) {}
    public void destroy() {}
}
