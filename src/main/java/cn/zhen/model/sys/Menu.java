package cn.zhen.model.sys;

//public class MenuModel implements  Comparable<MenuModel>{
public class Menu {
    private Integer menuID;
    private Integer menuPID;
    private String  menuName;
    private String  menuUrl;
    private String  menuIcon;
    private short   menuShow;
    private short   menuStatus;
    private Integer  menuPath;
    private Integer  menuLevel;

    public Integer getMenuLevel() {
        return menuLevel;
    }

    public void setMenuLevel(Integer menuLevel) {
        this.menuLevel = menuLevel;
    }

    public Integer getMenuID() {
        return menuID;
    }

    public void setMenuID(Integer menuID) {
        this.menuID = menuID;
    }

    public Integer getMenuPID() {
        return menuPID;
    }

    public void setMenuPID(Integer menuPID) {
        this.menuPID = menuPID;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getMenuUrl() {
        return menuUrl;
    }

    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }

    public String getMenuIcon() {
        return menuIcon;
    }

    public void setMenuIcon(String menuIcon) {
        this.menuIcon = menuIcon;
    }

    public short getMenuShow() {
        return menuShow;
    }

    public void setMenuShow(short menuShow) {
        this.menuShow = menuShow;
    }

    public short getMenuStatus() {
        return menuStatus;
    }

    public void setMenuStatus(short menuStatus) {
        this.menuStatus = menuStatus;
    }

    public Integer getMenuPath() {
        return menuPath;
    }

    public void setMenuPath(Integer menuPath) {
        this.menuPath = menuPath;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "menuID=" + menuID +
                ", menuPID=" + menuPID +
                ", menuName='" + menuName + '\'' +
                ", menuUrl='" + menuUrl + '\'' +
                ", menuIcon='" + menuIcon + '\'' +
                ", menuShow=" + menuShow +
                ", menuStatus=" + menuStatus +
                ", menuPath=" + menuPath +
                ", menuLevel=" + menuLevel +
                '}';
    }
}
