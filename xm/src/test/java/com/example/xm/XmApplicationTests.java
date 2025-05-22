package com.example.xm;

import com.example.xm.utils.OSSUtils;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockMultipartFile;

import java.io.File;
import java.io.FileInputStream;

@SpringBootTest
class XmApplicationTests {

    @Autowired
    private OSSUtils ossUtils;
    @Test
    public void testUploadVideo() throws Exception {
        // 本地视频文件路径（请根据实际修改）
        File file = new File("E:/bishe/music-new/video/1.mp4");

        // 调用上传方法
        String url = ossUtils.upload(file);

        System.out.println("上传成功！访问地址：" + url);
    }
}
