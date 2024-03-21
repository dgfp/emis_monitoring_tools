package com.emis.utility;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author shahaz
 */

public class Category implements Serializable {

    int id;
    String name;
    String icon;

    public ArrayList<Item> items;

    public Category(int id, String name, ArrayList<Item> items, String icon) {
        this.id = id;
        this.name = name;
        this.items = items;
        this.icon = icon;
    }

    public Category() {

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

    public ArrayList<Item> getItems() {
        return items;
    }

    public void setItems(ArrayList<Item> items) {
        this.items = items;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Override
    public String toString() {
        return "Category{" + "id=" + id + ", name=" + name + ", items=" + items + '}';
    }

}
