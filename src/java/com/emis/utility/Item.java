package com.emis.utility;

import java.io.Serializable;

/**
 *
 * @author shahaz
 */

public class Item implements Serializable {

    private int id;
    private String name;
    private String url;

    public Item(int id, String name, String url) {
        this.id = id;
        this.name = name;
        this.url = url;
    }

    public Item() {
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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Item{" + "id=" + id + ", name=" + name + ", url=" + url + '}';
    }

}
