package com.emis.service;

import com.emis.dao.AssetDao;
import com.emis.entity.AssetBACK;
import com.emis.utility.Convertor;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONArray;

/**
 *
 * @author Helal
 */
public class AssetService {

    private AssetDao assetDao = null;

    public AssetService() {
        assetDao = new AssetDao();
    }

    public AssetService(int districtId) {
        assetDao = new AssetDao(districtId);
    }

    public JSONArray getProviderType() throws SQLException, Exception {
        return assetDao.getProviderType();
    }

    public JSONArray getStatus() throws SQLException, Exception {
        return assetDao.getStatus();
    }

    public JSONArray getData(AssetBACK asset) throws SQLException, Exception {
        return assetDao.getData(asset);
    }

    public JSONArray getAssetDetails(String zillaid, String imei1, String providerid) throws SQLException, Exception {
        return assetDao.getAssetDetails(zillaid, imei1, providerid);
    }
    /*
    public JSONArray getDesignation() throws SQLException, Exception {
        return assetDao.getDesignation();
    }

    public JSONArray getDistributedData() throws SQLException, Exception {
        return assetDao.getDistributedData();
    }

    public JSONArray getDistributedAssetDetails(String imei1, String sim_number, String name_of_user, String providerid, String mobileno) throws SQLException, Exception {
        return assetDao.getDistributedAssetDetails(imei1, sim_number, name_of_user, providerid, mobileno);
    }

    public JSONArray getAssetBySelector(String designation, String status) throws SQLException, Exception {
        return assetDao.getAssetBySelector(designation, status);
    }

    public JSONArray getAssetByStatus(String status) throws SQLException, Exception {
        return assetDao.getAssetByStatus(status);
    }

    public JSONArray getMasterAsset() throws SQLException, Exception {
        return assetDao.getMasterAsset();
    }
     */
}
