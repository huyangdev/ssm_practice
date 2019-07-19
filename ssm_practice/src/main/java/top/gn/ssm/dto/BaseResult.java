package top.gn.ssm.dto;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * @author hy
 * 封装Controller层同一返回的结果
 */
//@JsonInclude(JsonInclude.Include.NON_NULL)
public class BaseResult implements Serializable {
	private static final long serialVersionUID = -4185151304730685014L;

	public static final int FAIL_CODE = -1;

    //	public static final int NO_PERMISSION = 2;
    //	public static final int NO_LOGIN = 1;

    private Map<String , Object> data = new HashMap<String , Object>(); // 返回的数据
    private boolean flag;  // 成功失败标志
    public static final int SUCCESS_CODE = 200;


    private String meg;  // 页面提示信息

    public BaseResult() {}

    /**
     * @author Hu Ji mi
     * @return
     * @date
     */
    public BaseResult(String meg, boolean flag, int code) {
        this.flag = flag;
        this.meg = meg;
        this.code = code;
    }

    /**
     * 成功时返回
     * @author Hu Ji mi
     * @date 19/07/2019 17:01
     */
    public static BaseResult success(){
        return new BaseResult("处理成功",true , SUCCESS_CODE);
    }

    /**
     * 失败时调用
     * @author Hu Ji mi
     * @date 19/07/2019 17:01
     */
    public static BaseResult fail(){
        return new BaseResult("处理失败" , false , FAIL_CODE);
    }


    /**
     * 添加要显示给前台的字段, 同时继续返回BaseResult对象
     * @author Hu Ji mi
     * @date 19/07/2019 17:13
     */
    public BaseResult addShowField(String key , Object value){
        // 可以进行一些 null的判断 ...
        this.data.put(key , value);
        return this;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public String getMeg() {
        return meg;
    }

    public void setMeg(String meg) {
        this.meg = meg;
    }

    private int code = 200;


    public static int getFailCode() {
        return FAIL_CODE;
    }

    public static int getSuccessCode() {
        return SUCCESS_CODE;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }



}
