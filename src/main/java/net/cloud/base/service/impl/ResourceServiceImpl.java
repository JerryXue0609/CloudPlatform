package net.cloud.base.service.impl;

import net.cloud.base.dao.IResourceDao;
import net.cloud.base.dao.support.IBaseDao;
import net.cloud.base.entity.Resource;
import net.cloud.base.entity.Role;
import net.cloud.base.service.IResourceService;
import net.cloud.base.service.IRoleService;
import net.cloud.base.service.support.impl.BaseServiceImpl;
import net.cloud.base.common.Constats;
import net.cloud.base.vo.ZtreeView;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * <p>
 * 资源表 服务实现类
 * </p>
 *
 * @author Jerry
 * @since 2016-12-28
 */
@Service
public class ResourceServiceImpl extends BaseServiceImpl<Resource, Integer>
        implements IResourceService {

    @Autowired
    private IResourceDao resourceDao;

    @Autowired
    private IRoleService roleService;

    @Override
    public IBaseDao<Resource, Integer> getBaseDao() {
        return this.resourceDao;
    }

    @Override
    @Cacheable(value = Constats.RESOURCECACHENAME, key = "'tree_' + #roleId")
    public List<ZtreeView> tree(int roleId) {
        List<ZtreeView> resulTreeNodes = new ArrayList<ZtreeView>();
        Role role = roleService.find(roleId);
        Set<Resource> roleResources = role.getResources();
        resulTreeNodes.add(new ZtreeView(-1L, null, "系统菜单", true));
        ZtreeView node;
        List<Resource> all = resourceDao.findAllByOrderByParentAscIdAscSortAsc();
        for (Resource resource : all) {
            node = new ZtreeView();
            node.setId(Long.valueOf(resource.getId()));
            if (resource.getParent() == null) {
                node.setpId(-1L);
            } else {
                node.setpId(Long.valueOf(resource.getParent().getId()));
            }
            node.setName(resource.getName());
            if (roleResources != null && roleResources.contains(resource)) {
                node.setChecked(true);
            }
            resulTreeNodes.add(node);
        }
        return resulTreeNodes;
    }

    @Override
    public void saveOrUpdate(Resource resource) {
        if (resource.getId() != null) {
            Resource dbResource = find(resource.getId());
            dbResource.setUpdateTime(new Date());
            dbResource.setName(resource.getName());
            dbResource.setSourceKey(resource.getSourceKey());
            dbResource.setType(resource.getType());
            dbResource.setSourceUrl(resource.getSourceUrl());
            dbResource.setLevel(resource.getLevel());
            dbResource.setSort(resource.getSort());
            dbResource.setIsHide(resource.getIsHide());
            dbResource.setIcon(resource.getIcon());
            dbResource.setDescription(resource.getDescription());
            dbResource.setUpdateTime(new Date());
            dbResource.setParent(resource.getParent());
            update(dbResource);
        } else {
            resource.setCreateTime(new Date());
            resource.setUpdateTime(new Date());
            save(resource);
        }
    }

    @Override
    public void delete(Integer id) {
        resourceDao.deleteGrant(id);
        super.delete(id);
    }

    @Override
    public Page<Resource> findAllByLike(String searchText, PageRequest pageRequest) {
        if (StringUtils.isBlank(searchText)) {
            searchText = "";
        }
        return resourceDao.findAllByNameContaining(searchText, pageRequest);
    }

}
