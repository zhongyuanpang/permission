package com.pzy;
import com.pzy.mapper.BlogMapper;
import com.pzy.mapper.UserMapper;
import com.pzy.utils.SecurityUtils;
import com.pzy.utils.uuid.IdUtils;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class BbsApplicationTests {

    @Autowired(required = false)
    private UserMapper userMapper;

    @Autowired(required = false)
    private BlogMapper blogMapper;
    @Test
    void contextLoads() {
        String password = "pangzy1013";
        System.out.println(SecurityUtils.encryptPassword(password));
        System.out.println(SecurityUtils.matchesPassword(password,"$2a$10$I5Y9aWjYA45EnqW2XZ0o3.UoNnAP6Ecbj.ZCfI7.9V2jM7pTU/Ruu"));
    }

    }
