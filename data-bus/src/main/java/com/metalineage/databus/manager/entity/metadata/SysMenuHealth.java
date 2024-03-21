package com.metalineage.databus.manager.entity.metadata;

public class SysMenuHealth {
    private Long menuId;

    private Integer isHealth;

    private String menuName;

    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public Integer getIsHealth() {
        return isHealth;
    }

    public void setIsHealth(Integer isHealth) {
        this.isHealth = isHealth;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName == null ? null : menuName.trim();
    }
}