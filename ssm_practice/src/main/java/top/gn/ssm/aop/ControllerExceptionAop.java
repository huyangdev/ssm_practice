package top.gn.ssm.aop;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import top.gn.ssm.dto.BaseResult;

/**
 * 用于捕获controller层的异常, 进行日志的处理的aop类
 */
public class ControllerExceptionAop {

    private static final Logger logger = Logger.getLogger(ControllerExceptionAop.class);

    public Object handlerControllerMethod(ProceedingJoinPoint pjp){
        long startTime = System.currentTimeMillis();
        BaseResult result;

        try{
            result = (BaseResult) pjp.proceed();
            long useTime = System.currentTimeMillis() - startTime;
            logger.info(pjp.getSignature() + "use time(Millis) " + useTime);
        }catch(Throwable e){
            result = handlerException(pjp,e);
        }
        return result;
    }

    private BaseResult handlerException(ProceedingJoinPoint pjp,Throwable e){
        BaseResult result = new BaseResult();
/*
        // 已知异常
        if(e instanceof XXXException){
            result.setMsg(e.getLocalizedMessage());
            result.setCode(对应code);
        }else if(e instanceof UnloginException){
            result.setMsg("Unlogin");
            result.setCode(BaseResult.No_LOGIN);
        }else{
            // 未知异常 必要时可以发送邮件用于提醒
            logger.error(pjp.getSignature() + " error" ,e);
            result.setMsg(e.toString());
            result.setCode(BaseResult.FAIL_CODE);
        }
*/
/*
    <bean id="controllerAop" class="top.gn.ssm.aop.ControllerExceptionAop"/>
    <aop:config>
        <aop:aspect ref="controllerAop">
            <aop:pointcut expression="execution(public top.gn.ssm.service.**(..))" id="targer"></aop:pointcut>
            <aop:around method="handlerControllerMethod" pointcut-ref="targer"/>
        </aop:aspect>
    </aop:config>
*/
        return result;

    }



}
