package cn.zhen.model.sys;

public class Role {
    private Integer roleID;
    private String roleName;
    private String roleMenus;
    private String roleIntro;

    public Integer getRoleID() {
        return roleID;
    }

    public void setRoleID(Integer roleID) {
        this.roleID = roleID;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleMenus() {
        return roleMenus;
    }

    public void setRoleMenus(String roleMenus) {
        this.roleMenus = roleMenus;
    }

    public String getRoleIntro() {
        return roleIntro;
    }

    public void setRoleIntro(String roleIntro) {
        this.roleIntro = roleIntro;
    }

    @Override
    public String toString() {
        return "Role{" +
                "roleID=" + roleID +
                ", roleName='" + roleName + '\'' +
                ", roleMenus='" + roleMenus + '\'' +
                ", roleIntro='" + roleIntro + '\'' +
                '}';
    }
}
