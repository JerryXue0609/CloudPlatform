package net.cloud.base.service;

import net.cloud.base.common.JsonResult;
import net.cloud.base.entity.Device;
import net.cloud.base.service.support.IBaseService;

/**
 * Created by Jerry on 2018/5/3 0003.
 */
public interface IDeviceService extends IBaseService<Device,Integer>{
    /**
     * 对外接口：设备注册，返回JSON
     * @param jsonData
     * @return
     */
    JsonResult save(String jsonData);

    /**
     *
     *对外接口：接收设备name，更新update_time
     */

    JsonResult updateTime(String jsonData);
}
