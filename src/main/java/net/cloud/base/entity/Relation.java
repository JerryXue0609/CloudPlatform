package net.cloud.base.entity;

import net.cloud.base.entity.support.BaseEntity;

import javax.persistence.*;

@Entity
@Table(name = "tb_relation")
public class Relation extends BaseEntity{
    /**
     * 关系id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;

    /**
     * 用户id
     */
    private Integer user_id;

    /**
     * 设备id
     */
    private Integer device_id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }
    public Integer getDevice_id() {
        return device_id;
    }

    public void setDevice_id(Integer device_id) {
        this.device_id = device_id;
    }
}
