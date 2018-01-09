package com.wrq.manage.common;

/**
 * Created by 王乾 on 2018/1/9.
 */

import java.util.HashMap;
import java.util.Map;

/**
 * 返回json通用的数据
 */
public class Msg {
    //状态码 100-成功 200-失败
    private int code;

    //提示信息
    private String msg;

    //用户要返回给浏览器的数据
    private Map<String,Object> data = new HashMap<String, Object>();

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    //链式操作
    public  Msg add(String key,Object value){
        this.getData().put(key,value);
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
