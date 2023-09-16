package Filter;

import model.Account;
import security.PermissionValidate;
import security.PrivateResource;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"/*"},asyncSupported = true)
public class SecurityFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String resource = httpRequest.getServletPath();
        String requestFrom= httpRequest.getHeader("Referer");

        if (PrivateResource.PRIVATE_RESOURCE.containsValue(resource)) {
            Account account = (Account) httpRequest.getSession().getAttribute("user");
            if (account == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/anime-main/Index");
                return;
            } else {
                boolean checkPermission = PermissionValidate.userHasPermission(account,resource);
                if (!checkPermission ) {
                    httpResponse.sendRedirect("/Error.jsp");
                    return;
                }
            }


        }
        if(resource.contains("/storage/chapters/")&&(requestFrom==null||!requestFrom.contains("WatchingMovie"))){
            httpResponse.sendRedirect("/Error.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

}