package net.cloud.base.service.impl;

import com.alibaba.fastjson.JSON;
import net.cloud.base.common.JsonResult;
import net.cloud.base.dao.IDeviceDao;
import net.cloud.base.dao.support.IBaseDao;
import net.cloud.base.entity.Device;
import net.cloud.base.service.IDeviceService;
import net.cloud.base.service.support.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Jerry on 2018/5/3 0003.
 */
@Service
public class DeviceServiceImpl extends BaseServiceImpl<Device, Integer> implements IDeviceService {

    @Autowired
    private IDeviceDao deviceDao;

    @Override
    public IBaseDao<Device, Integer> getBaseDao() {
        return this.deviceDao;
    }

    @Override
    public JsonResult save(String jsonData) {
        Device device = JSON.parseObject(jsonData, Device.class);
        Device CheckName =deviceDao.findByName(device.getName());
        if (CheckName != null){
            return JsonResult.registerError("设备已存在");
        }
        if (device.getName()==null || device.getPort_a()==null || device.getPort_c()==null){
            return JsonResult.registerError("设备名或语音端口或控制端口不能为空");
        }
        device.setName(device.getName());
        device.setPort_a(device.getPort_a());
        device.setPort_c(device.getPort_c());
        device.setUpdate_time(new Date());
        deviceDao.save(device);
        return JsonResult.registerSuccess("设备："+device.getName()+"注册成功");
    }

    @Override
    public JsonResult updateTime(String jsonData) {
        Device device = JSON.parseObject(jsonData, Device.class);
        Device CheckName =deviceDao.findByName(device.getName());
        if (CheckName == null){
            return JsonResult.registerError("设备不存在");
        }
        String newDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        deviceDao.updateTimeByName(new Date(),device.getName());
        return JsonResult.registerSuccess("设备："+device.getName()+"更新时间成功!"+newDate);
    }

    @Override
    public void saveOrUpdate(Device device) {
        if (device.getId() != null) {
            Device dbdevice = find(device.getId());
            dbdevice.setName(device.getName());
            dbdevice.setPort_a(device.getPort_a());
            dbdevice.setPort_c(device.getPort_c());
            dbdevice.setUpdate_time(new Date());
            update(dbdevice);
        }
    }

}
