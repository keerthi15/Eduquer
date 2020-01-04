package org.Eduquer;
import sun.reflect.annotation.EnumConstantNotPresentExceptionProxy;

import java.sql.*;
import java.io.*;
import java.lang.*;
import java.util.*;

public class testLoad1 {
    Connection conn;
    String url;
    String dbName;
    String driver;
    PreparedStatement st;
    int count=0,noq=0,duration=0,testid=0,uid=0,noOfQues=0;
    String quesId;
    int[] questionid = new int[5];
    public testLoad1(Connection conn, String url, String dbName, String driver) {

        this.conn = conn;
        this.url = url;
        this.dbName = dbName;
        this.driver = driver;
        System.out.println("hello");
    }
    public void getConn() {
        try {

            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url + dbName, "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public ResultSet getQues(int testid, int userid, int complexity){
        ResultSet rs = null;
        try{
            String q="";
            int i;

            PreparedStatement st = (PreparedStatement)conn.prepareStatement("SELECT count(TestId) FROM `test_questions` WHERE TestId=? and Complexity=?");
            st.setInt(1,testid);
            st.setInt(2,complexity);
            rs= st.executeQuery();
            int count=0;
            while(rs.next()){
                count=rs.getInt(1);
            }
            int complexityques[] = new int[count];
            st = (PreparedStatement)conn.prepareStatement("select * from test_questions where TestId=? and Complexity=?");
            st.setInt(1,testid);
            st.setInt(2,complexity);
            rs= st.executeQuery();

            i=0;

            while(rs.next()){

                complexityques[i++]= rs.getInt("QuestionID");
            }

            PreparedStatement pst = (PreparedStatement)conn.prepareStatement("Select * from report where TestID= ? and UserID=?");
            pst.setInt(1,testid);
            pst.setInt(2,userid);
            ResultSet r = pst.executeQuery();
            while(r.next()){
                q = r.getString("Questions");
                System.out.println(q);
            }
            int questID=0;
            if(q.length()>0){
                System.out.println("if executed");
                String quesid [] = q.split(",");
                int questions[] = new int[quesid.length];
                for(i=0;i<quesid.length;i++){
                    questions[i]= Integer.parseInt(quesid[i]);
                    System.out.print(questions[i]+" ");
                }
                int flag=0;
                while (flag==0){
                    int rnd = new Random().nextInt(complexityques.length);
                    int randomID= complexityques[rnd];
                    for(i=0;i<quesid.length;i++){
                        if(questions[i]==randomID){
                            flag=0;
                            break;
                        }

                    }
                    if(i==quesid.length) {
                        flag=1;
                    }
                    if(flag==1){
                        questID=randomID;
                        break;
                    }

                }
                q=q+questID+',';
                System.out.println(q);
                st =(PreparedStatement)conn.prepareStatement("Update report set Questions = ? where TestID=? and UserID=?");
                st.setString(1,q);
                st.setInt(2,testid);
                st.setInt(3,userid);
                st.executeUpdate();

            }
            else {
                System.out.println("else executed");
                int rnd = new Random().nextInt(complexityques.length);
                questID= complexityques[rnd];
                q=q+questID+',';
                System.out.println(q);
                st=(PreparedStatement)conn.prepareStatement("insert into report (TestID,UserID,Questions)values(?,?,?)");
                st.setInt(1,testid);
                st.setInt(2,userid);
                st.setString(3,q);
                st.executeUpdate();
            }
            st=(PreparedStatement)conn.prepareStatement("Select * from test_questions where QuestionID=?");
            st.setInt(1,questID);
            rs = st.executeQuery();

        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

}

