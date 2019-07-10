package top.gn.ssm.dto;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.io.Serializable;

/**
 * 
 * @author hy
 *
 * 封装Controller层同一返回的结果
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BaseResult<T> implements Serializable {


	private static final long serialVersionUID = -4185151304730685014L;

	private boolean success;  // 成功失败标志

    private T data; // 返回的数据

    private String mag;  // 页面提示信息


    /**
     * 查询成功时调用
     * @author Hu Ji mi
     * @return
     * @date
     */
    public BaseResult(String mag, T data) {
        this.success = true;
        this.mag = mag;
        this.data = data;
    }

    /**
     * 查询失败时调用
     * @author Hu Ji mi
     * @date 10/07/2019 20:51
     */
    public BaseResult(String mag) {
        this.success = false;
        this.mag = mag;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getMag() {
        return mag;
    }

    public void setMag(String mag) {
        this.mag = mag;
    }

    @Override
	public String toString() {
		return "BaseResult [success=" + success + ", data=" + data + ", mag=" + mag + "]";
	}

}
