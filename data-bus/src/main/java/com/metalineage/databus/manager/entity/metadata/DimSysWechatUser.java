package com.metalineage.databus.manager.entity.metadata;

public class DimSysWechatUser {
    private Integer userId;

    private String nickName;

    private String deptName1;

    private String deptName2;

    private String deptName3;

    private String deptName4;

    private String delFalg;

    private String status;

    private String userCreateDate;

    private String email;

    private String phonenumber;

    private String sex;

    private String postName;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName == null ? null : nickName.trim();
    }

    public String getDeptName1() {
        return deptName1;
    }

    public void setDeptName1(String deptName1) {
        this.deptName1 = deptName1 == null ? null : deptName1.trim();
    }

    public String getDeptName2() {
        return deptName2;
    }

    public void setDeptName2(String deptName2) {
        this.deptName2 = deptName2 == null ? null : deptName2.trim();
    }

    public String getDeptName3() {
        return deptName3;
    }

    public void setDeptName3(String deptName3) {
        this.deptName3 = deptName3 == null ? null : deptName3.trim();
    }

    public String getDeptName4() {
        return deptName4;
    }

    public void setDeptName4(String deptName4) {
        this.deptName4 = deptName4 == null ? null : deptName4.trim();
    }

    public String getDelFalg() {
        return delFalg;
    }

    public void setDelFalg(String delFalg) {
        this.delFalg = delFalg == null ? null : delFalg.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getUserCreateDate() {
        return userCreateDate;
    }

    public void setUserCreateDate(String userCreateDate) {
        this.userCreateDate = userCreateDate == null ? null : userCreateDate.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber == null ? null : phonenumber.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName == null ? null : postName.trim();
    }
}