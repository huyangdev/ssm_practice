package tools.annotation;


import java.lang.annotation.*;

/**
 * 用于前台传入List时, 封装List参数
 */
@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ListParam {
    public Class<?> value();
    public String name();
}
