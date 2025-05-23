package org.example.jspConfig;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class Application extends AbstractAnnotationConfigDispatcherServletInitializer {
    protected Class<?>[] getRootConfigClasses() {
        return new Class<?>[] { };
    }
    protected Class<?>[] getServletConfigClasses() {
        return new Class<?>[] { SpringServletConfig.class };
    }
    protected String[] getServletMappings() {
        return new String[] { "/*" };
    }
}
