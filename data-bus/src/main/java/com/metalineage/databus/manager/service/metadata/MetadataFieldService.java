package com.metalineage.databus.manager.service.metadata;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.metalineage.databus.manager.entity.metadata.MetadataField;
import com.metalineage.databus.manager.mapper.metadata.ManagerMetadataFieldMapper;

import java.util.List;

@Service
public class MetadataFieldService {

    @Autowired(required = false)
    ManagerMetadataFieldMapper managerMetadataFieldMapper;

    public int deleteByPrimaryKey(Integer id){
        return managerMetadataFieldMapper.deleteByPrimaryKey(id);
    };

    public int insert(MetadataField record){
        return managerMetadataFieldMapper.insert(record);
    };

    public int insertSelective(MetadataField record){
        return managerMetadataFieldMapper.insertSelective(record);
    };

    public MetadataField selectByPrimaryKey(Integer id){
        return managerMetadataFieldMapper.selectByPrimaryKey(id);
    };

    public int updateByPrimaryKeySelective(MetadataField record){
        return managerMetadataFieldMapper.updateByPrimaryKeySelective(record);
    };

    public int updateByPrimaryKey(MetadataField record){
        return managerMetadataFieldMapper.updateByPrimaryKey(record);
    };

    public void insertBatch(List<MetadataField> metadataFieldList){
        managerMetadataFieldMapper.insertBatch(metadataFieldList);
    };

    public MetadataField findOneFieldByFieldInfo(MetadataField record){
        List<MetadataField> metadataFieldList = findFieldByFieldInfo(record,1,1);
        if(metadataFieldList==null||metadataFieldList.size()==0){
            return null;
        } else{
            return metadataFieldList.get(0);
        }
    };

    public List<MetadataField> findFieldByFieldInfo(MetadataField record, int page, int pageSize){
        if(pageSize>100){
            pageSize = 100;
        }
        if(page<=0){
            page=1;
        }
        int startOffset = (page-1)*pageSize;
        return managerMetadataFieldMapper.findFieldByFieldInfo(record,startOffset,pageSize);
    };

    public int upsert(MetadataField record){
        if(record.getId()!=null){
            managerMetadataFieldMapper.updateByPrimaryKeySelective(record);
            return record.getId();
        }
        MetadataField oneRecord = findOneFieldByFieldInfo(record);
        if(oneRecord!=null){
            record.setId(oneRecord.getId());
            managerMetadataFieldMapper.updateByPrimaryKeySelective(record);
            return record.getId();
        } else{
            managerMetadataFieldMapper.insertSelective(record);
            return 1;
        }
    }

    public void deleteAll(){
        managerMetadataFieldMapper.deleteAll();
    };

}