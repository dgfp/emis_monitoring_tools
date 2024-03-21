package com.emis.service;

import com.emis.dao.UserDao;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class UserService {

    private UserDao userDao = null;

    public UserService() {
        userDao = new UserDao();
    }

    public JSONArray getUser() throws Exception {
        return userDao.getUser();
    }

    public JSONArray getUserRole() throws Exception {
        return userDao.getUserRole();
    }

    public JSONArray getUserLogById(String userId) throws Exception {
        return userDao.getUserLogById(userId);
    }
}
