package com.metalineage.databus.manager.service.metadata;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.metalineage.databus.manager.entity.metadata.MetadataTable;
import com.metalineage.databus.manager.mapper.metadata.ManagerMetadataTableMapper;

import java.util.Date;
import java.util.List;

@Service
public class MetadataTableService {

    @Autowired(required = false)
    ManagerMetadataTableMapper metadataTableMapper;

    public int deleteByPrimaryKey(Integer id){
        return metadataTableMapper.deleteByPrimaryKey(id);
    };

    public int insert(MetadataTable record){
        return metadataTableMapper.insert(record);
    };

    public int insertSelective(MetadataTable record){
        return metadataTableMapper.insertSelective(record);
    };

    public MetadataTable selectByPrimaryKey(Integer id){
        return metadataTableMapper.selectByPrimaryKey(id);
    };

    public int updateByPrimaryKeySelective(MetadataTable record){
        return metadataTableMapper.updateByPrimaryKeySelective(record);
    };

    public void insertBatch(List<MetadataTable> metadataFieldList){
        metadataTableMapper.insertBatch(metadataFieldList);
    };


    public int updateByPrimaryKey(MetadataTable record){
        return metadataTableMapper.updateByPrimaryKey(record);
    };

    public boolean metaDataTableIsExist(MetadataTable record){
        List<MetadataTable> metadataTable = metadataTableMapper.findTableByTableInfo(record,0,1);
        return metadataTable.size()!=0;
    }

    public int upsert(MetadataTable record){
        if(record.getId()!=null){
            record.setUpdateTime(new Date());
            metadataTableMapper.updateByPrimaryKeySelective(record);
            return record.getId();
        }
        String deleteString = record.getDbType();
        record.setDbType(null);
        MetadataTable oneRecord = findOneTableByTableInfo(record);
        record.setDbType(deleteString);
        if(oneRecord!=null){
            record.setId(oneRecord.getId());
            record.setUpdateTime(new Date());
            metadataTableMapper.updateByPrimaryKeySelective(record);
        } else{
            record.setUpdateTime(new Date());
            record.setCreateTime(new Date());
            metadataTableMapper.insertSelective(record);
        }
        return record.getId();
    }

    public MetadataTable findOneTableByTableInfo(MetadataTable record){
        List<MetadataTable> metadataTableList = findTableByTableInfo(record,1,1);
        if(metadataTableList==null||metadataTableList.size()==0){
            return null;
        } else{
            return metadataTableList.get(0);
        }
    };

    public List<MetadataTable> findTableByTableInfo(MetadataTable record){
        return findTableByTableInfo(record,1,10);
    };

    public List<MetadataTable> findTableByTableInfo(MetadataTable record,int page,int pageSize){
        if(pageSize>100){
            pageSize = 100;
        }
        if(page<=0){
            page=1;
        }
        int startOffset = (page-1)*pageSize;
        return metadataTableMapper.findTableByTableInfo(record,startOffset,pageSize);
    };

    public List<MetadataTable> findTableByTableInfoFuzzy(MetadataTable record){
        return findTableByTableInfoFuzzy(record,1,10);
    };

    public List<MetadataTable> findTableByTableInfoFuzzy(MetadataTable record,int page,int pageSize){
        if(pageSize>100){
            pageSize = 100;
        }
        if(page<=0){
            page=1;
        }
        int startOffset = (page-1)*pageSize;
        return metadataTableMapper.findTableByTableInfoFuzzy(record,startOffset,pageSize);
    };

    public MetadataTable findById(int id){
        List<MetadataTable> metadataTables = metadataTableMapper.findById(id);
        return metadataTables.size() >0 ? metadataTables.get(0) : null;
    }

    public void deleteAll(){
        metadataTableMapper.deleteAll();
    }

    public List<String> findDeleteName(){
        return metadataTableMapper.findDeleteName();
    };

}