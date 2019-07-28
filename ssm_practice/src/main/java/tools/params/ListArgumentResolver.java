package tools.params;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import tools.annotation.ListParam;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * List集合参数解析器
 */
public class ListArgumentResolver implements HandlerMethodArgumentResolver {

    /**
     *
     * @author Hu Ji mi
     * @param parameter 方法的参数
     * @return 当前解析器是否支持该参数
     * @date 2019/7/28 11:47
     */
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        // 判断是否有 @ListParam 自定义注解, 并且 需要是List类型 若有代表为解析器处理
        if (null != parameter.getParameterAnnotation(ListParam.class)
                && List.class.equals(parameter.getParameterType())) {
            return true;
        }
        return false;
    }

    /**
     *
     * @author Hu Ji mi
     * @methodName
     * @param parameter : 需要处理的参数
     *        mvcContainer: 当前请求的ModelAndView
     *        webRequest: 当前请求的 request 对象
     *        binderFactory: 用于创建 WebDataBinder 对象的工厂
     *        先使用webRequest.getParameterValues(String paramName)获取request中的参数数组，
     *                  遍历添加到List<MutablePropertyValues>中，以分配给各个对象。
     *                  再循环使用ServletRequestDataBinder绑定PropertyValues进行类型转换，得到需要的对象集合。
     * @return
     * @date 2019/7/28 11:52
     */
    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
                                  NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        ListParam parameterAnnotation = parameter.getParameterAnnotation(ListParam.class);
        String name = parameterAnnotation.name();
        System.out.println("name: "+name);

        String[] parameterValues = webRequest.getParameterValues(name);
        System.out.println("parameterValues: "+ Arrays.toString(parameterValues));
//        MutablePropertyValues mutablePropertyValues = null;
        // 获取List当中的泛型对象
        Class<?> elementClass = getElementTypeFromAnnotation(parameter);
        List<Object> list = new ArrayList<Object>();
        return list;



//        List<MutablePropertyValues> mpvList = new ArrayList<MutablePropertyValues>();
//
//        Field[] fields = elementClass.getDeclaredFields();
//
//        for (Field field : fields) {
//            parameterValues = webRequest.getParameterValues(field.getName());
//            if (null == parameterValues) {
//                continue;
//            }
//            for (int i = 0; i < parameterValues.length; i++) {
//                if (mpvList.size() <= i) {
//                    mutablePropertyValues = new MutablePropertyValues();
//                    mutablePropertyValues.add(field.getName(), parameterValues[i]);
//                    mpvList.add(mutablePropertyValues);
//                } else {
//                    mutablePropertyValues = mpvList.get(i);
//                    mutablePropertyValues.add(field.getName(), parameterValues[i]);
//                }
//            }
//        }
//
//        String name = ClassUtils.getShortNameAsProperty(elementClass);
//        Object attribute = null;
//        WebDataBinder binder = null;
//        ServletRequestDataBinder servletBinder = null;
//        Object element = null;
//        List<Object> actualParameter = new ArrayList<Object>(mpvList.size());
//        for (int i = 0; i < mpvList.size(); i++) {
//            attribute = BeanUtils.instantiateClass(elementClass);
//            binder = binderFactory.createBinder(webRequest, attribute, name);
//            servletBinder = (ServletRequestDataBinder) binder;
//            servletBinder.bind(mpvList.get(i));
//            element = binder.getTarget();
//            actualParameter.add(binder.convertIfNecessary(element, elementClass, parameter));
//        }
//        return actualParameter;
    }

    // 获取List当中的泛型对象
    private Class<?> getElementTypeFromAnnotation(MethodParameter parameter) {
        ListParam parameterAnnotation = parameter.getParameterAnnotation(ListParam.class);
        return parameterAnnotation.value();
    }
}














