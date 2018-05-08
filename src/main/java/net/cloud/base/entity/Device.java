package net.cloud.base.entity;

import com.alibaba.fastjson.annotation.JSONField;
import net.cloud.base.entity.support.BaseEntity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "tb_device")
public class Device extends BaseEntity{
    private static final long serialVersionUID = 1L;

    /**
     * 设备id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;

    /**
     * 设备名
     */
    private String name;

    /**
     *语音端口
     */
    private Integer port_a;

    /**
     *控制端口
     */
    private Integer port_c;

    /**
     * 更新时间
     */
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date update_time;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPort_a() {
        return port_a;
    }

    public void setPort_a(Integer port_a) {
        this.port_a = port_a;
    }

    public Integer getPort_c() {
        return port_c;
    }

    public void setPort_c(Integer port_c) {
        this.port_c = port_c;
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
    }
}
