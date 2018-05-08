package net.cloud.base.dao;

import net.cloud.base.dao.support.IBaseDao;
import net.cloud.base.entity.Device;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * Created by Jerry on 2018/5/3 0003.
 */
@Repository
public interface IDeviceDao extends IBaseDao<Device,Integer>{
    Device findByName(String name);

    @Transactional
    @Modifying
    @Query(nativeQuery = true, value = "update tb_device d set d.update_time =?1 where d.NAME = ?2")
    int updateTimeByName(Date time,String name);
}
