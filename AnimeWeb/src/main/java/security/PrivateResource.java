package security;

import java.util.HashMap;
import java.util.Map;

public class PrivateResource {
    public static final Map<String,String> PRIVATE_RESOURCE = new HashMap<String,String>();

    static {
        //dashboard
        PRIVATE_RESOURCE.put("dashBoard","/admin/dashBoard");

        //BLog
        PRIVATE_RESOURCE.put("BlogList","/admin/BlogList");
        PRIVATE_RESOURCE.put("BlogEdit","/admin/BlogEdit");
        PRIVATE_RESOURCE.put("AddBlog","/admin/AddBlog");
        PRIVATE_RESOURCE.put("RemoveBlog","/admin/RemoveBlog");


        //log
        PRIVATE_RESOURCE.put("RemoveLog","/admin/RemoveLog");
        PRIVATE_RESOURCE.put("LogList","/admin/LogList");
        //movie
        PRIVATE_RESOURCE.put("MovieList","/admin/MovieList");
        PRIVATE_RESOURCE.put("MovieEdit","/admin/MovieEdit");
        PRIVATE_RESOURCE.put("MovieAdd","/admin/MovieAdd");
        PRIVATE_RESOURCE.put("RemoveMovie","/admin/RemoveMovie");
        PRIVATE_RESOURCE.put("ChapterSetting","/admin/ChapterSetting");
        PRIVATE_RESOURCE.put("GenreList","/admin/GenreList");
        PRIVATE_RESOURCE.put("InsertGenre","/admin/InsertGenre");
        PRIVATE_RESOURCE.put("RemoveChapter","/admin/RemoveChapter");
        PRIVATE_RESOURCE.put("RemoveGenre","/admin/RemoveGenre");
        PRIVATE_RESOURCE.put("SettingGenre","/admin/SettingGenre");
        PRIVATE_RESOURCE.put("ImportCoupons","/admin/ImportCoupons");
        //account
        PRIVATE_RESOURCE.put("UserList","/admin/UserList");
        PRIVATE_RESOURCE.put("UserEdit","/admin/UserEdit");
        PRIVATE_RESOURCE.put("UserAdd","/admin/UserAdd");
        PRIVATE_RESOURCE.put("RemoveUser","/admin/RemoveUser");
        PRIVATE_RESOURCE.put("UnlockUser","/admin/UnlockUser");
        PRIVATE_RESOURCE.put("LockUser","/admin/LockUser");
        PRIVATE_RESOURCE.put("EditPasswordAccount","/admin/EditPasswordAccount");
        PRIVATE_RESOURCE.put("AddUserRole","/admin/AddUserRole");
        PRIVATE_RESOURCE.put("RemoveUserRole","/admin/RemoveUserRole");
        PRIVATE_RESOURCE.put("SettingUserPermission","/admin/SettingUserPermission");
        //bonus
        PRIVATE_RESOURCE.put("BonusList","/admin/BonusList");
        PRIVATE_RESOURCE.put("EditBonus","/admin/EditBonus");
        PRIVATE_RESOURCE.put("AddBonus","/admin/AddBonus");
        PRIVATE_RESOURCE.put("RemoveBonus","/admin/RemoveBonus");
        PRIVATE_RESOURCE.put("DisplayBonus","/admin/DisplayBonus");
        PRIVATE_RESOURCE.put("HideBonus","/admin/HideBonus");
        PRIVATE_RESOURCE.put("SettingBonusMovie","/admin/SettingBonusMovie");
        PRIVATE_RESOURCE.put("AddBonusMovie","/admin/AddBonusMovie");
        PRIVATE_RESOURCE.put("RemoveBonusMovie","/admin/RemoveBonusMovie");
        //Producer
        PRIVATE_RESOURCE.put("AddProducer","/admin/AddProducer");
        PRIVATE_RESOURCE.put("DisplayProducer","/admin/DisplayProducer");
        PRIVATE_RESOURCE.put("EditProducer","/admin/EditProducer");
        PRIVATE_RESOURCE.put("HideProducer","/admin/HideProducer");
        PRIVATE_RESOURCE.put("ProducerList","/admin/ProducerList");
        PRIVATE_RESOURCE.put("RemoveProducer","/admin/RemoveProducer");

        //Supplier
        PRIVATE_RESOURCE.put("AddSupplier","/admin/AddSupplier");
        PRIVATE_RESOURCE.put("DisplaySupplier","/admin/DisplaySupplier");
        PRIVATE_RESOURCE.put("EditSupplier","/admin/EditSupplier");
        PRIVATE_RESOURCE.put("HideSupplier","/admin/HideSupplier");
        PRIVATE_RESOURCE.put("RemoveSupplier","/admin/RemoveSupplier");
        PRIVATE_RESOURCE.put("SupplierList","/admin/SupplierList");
        //WishList
        PRIVATE_RESOURCE.put("PurchasedHistory","/admin/PurchasedHistory");
        PRIVATE_RESOURCE.put("removePurchased","/admin/removePurchased");
        PRIVATE_RESOURCE.put("removeTransactionHistory","/admin/removeTransactionHistory");
        PRIVATE_RESOURCE.put("revenue","/api/revenue-by-month");
        PRIVATE_RESOURCE.put("TransactionHistory","/admin/TransactionHistory");
        //role
        PRIVATE_RESOURCE.put("AddRole","/admin/AddRole");
        PRIVATE_RESOURCE.put("EditRole","/admin/EditRole");
        PRIVATE_RESOURCE.put("RolePage","/admin/RolePage");
        PRIVATE_RESOURCE.put("RemoveRole","/admin/RemoveRole");
    }

}
