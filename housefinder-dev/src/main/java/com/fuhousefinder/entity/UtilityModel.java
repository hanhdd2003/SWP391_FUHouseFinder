package com.fuhousefinder.entity;

/**
 *
 * @author hp
 */
public class UtilityModel {
    private int id;
    private String name;

    public UtilityModel() {
    }

    public UtilityModel(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String utilityImg() {
        switch (name) {
            case "Điều hòa":
                return "dieuhoa.png";
            case "Wifi":
                return "wifi.jpg";
            case "Nóng lạnh":
                return "nonglanh.png";
            case "Bàn Học":
                return "banhoc.jpg";
            case "Giường":
                return "giuong.jpg";
            case "Tủ quần áo":
                return "tuquanao.png";
            case "Bàn bếp":
                return "banbep.png";
            case "Quạt":
                return "quat.png";
            case "Tủ lạnh":
                return "tulanh.png";
            case "Hệ thống hút mùi":
                return "hutmui.png";
            case "Bồn rửa":
                return "bonrua.png!sw800";
            default:
                return "";
        }
    }
}
