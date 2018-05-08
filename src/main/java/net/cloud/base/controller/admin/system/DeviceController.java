package net.cloud.base.controller.admin.system;

import net.cloud.base.common.JsonResult;
import net.cloud.base.controller.BaseController;
import net.cloud.base.entity.Device;
import net.cloud.base.service.IDeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Jerry on 2018/5/3 0003.
 */

@Controller
@RequestMapping("admin/dev")
public class DeviceController extends BaseController {
    @Autowired
    private IDeviceService devService;

    @RequestMapping(value = {"/index"})
    public String index(ModelMap modelMap) {
        Page<Device> page = devService.findAll(getPageRequest());
        modelMap.put("pageInfo", page);
        return "admin/dev/index";
    }

    @PostMapping(value = "/register")
    @ResponseBody
    public JsonResult register(@RequestBody String jsonData) {
        return devService.save(jsonData);
    }

    @PostMapping(value = "/updateTime")
    @ResponseBody
    public JsonResult updateTime(@RequestBody String jsonData) {
        return devService.updateTime(jsonData);
    }
}
