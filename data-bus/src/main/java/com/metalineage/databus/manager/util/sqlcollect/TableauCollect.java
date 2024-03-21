package com.metalineage.databus.manager.util.sqlcollect;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.metalineage.databus.manager.entity.metadata.TableauSql;
import com.metalineage.databus.manager.mapper.metadata.TableauSqlMapper;

import java.util.List;

@Service
public class TableauCollect {
    @Autowired(required = false)
    TableauSqlMapper tableauSqlMapper;

    public List<TableauSql> findTableauByTableauInfo(TableauSql record,int page, int pageSize){
        if(pageSize>100){
            pageSize = 100;
        }
        if(page<=0){
            page=1;
        }
        int startOffset = (page-1)*pageSize;
        return tableauSqlMapper.findTableauByTableauInfo(record,startOffset,pageSize);
    };

    /**
     * 获取所有tableau中的sql信息
     */
    public JSONObject getAllTableauSql(){
        JSONObject jsonObject = new JSONObject();
        int i = 1;
        while(true){
            List<TableauSql> tableauSqls = findTableauByTableauInfo(new TableauSql(),i, 50);
            for (TableauSql tableauSql : tableauSqls) {
                String workbookPath = tableauSql.getWorkbookPath();
                String workbook = tableauSql.getWorkbook();
                if(!workbookPath.contains("废弃报表")){
                    JSONArray jsonArray = jsonObject.getJSONArray(workbook);
                    if(jsonArray==null){
                        jsonArray = new JSONArray();
                    }
                    jsonArray.add(tableauSql);
                    jsonObject.put(tableauSql.getWorkbook(),jsonArray);
                }
            }
            if(tableauSqls.size()!=50){
                break;
            }
            i+=1;
        }
        return jsonObject;
    };

    public static void main(String[] args) {

    }

}
