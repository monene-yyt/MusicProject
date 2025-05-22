package com.example.xm.utils;

import com.aliyun.oss.ClientBuilderConfiguration;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.common.auth.CredentialsProviderFactory;
import com.aliyun.oss.common.auth.EnvironmentVariableCredentialsProvider;
import com.aliyun.oss.common.comm.SignVersion;
import com.aliyun.oss.model.CannedAccessControlList;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;
import com.aliyun.oss.model.PutObjectResult;
import com.aliyuncs.exceptions.ClientException;
import com.example.xm.common.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Random;
import java.util.UUID;

@Component
public class OSSUtils {
    @Value("${aliyun.oss.endpoint}")
    private String endpoint;
    @Value("${aliyun.oss.accessKeyId}")
    private String accessKeyId;
    @Value("${aliyun.oss.accessKeySecret}")
    private String accessKeySecret;
    @Value("${aliyun.oss.bucketName}")
    private String bucketName;

    public Result uploadVideo(File file) {
        EnvironmentVariableCredentialsProvider credentialsProvider = null;
        try {
            credentialsProvider = CredentialsProviderFactory.newEnvironmentVariableCredentialsProvider();
        } catch (ClientException e) {
            return Result.error("环境变量获取失败");
        }
        String region = "cn-shanghai";
        String objectName = "video/" + file.getName();
        // 创建OSSClient实例。
        ClientBuilderConfiguration clientBuilderConfiguration = new ClientBuilderConfiguration();
        clientBuilderConfiguration.setSignatureVersion(SignVersion.V4);
        OSS ossClient = OSSClientBuilder.create()
                .endpoint(endpoint)
                .credentialsProvider(credentialsProvider)
                .clientConfiguration(clientBuilderConfiguration)
                .region(region)
                .build();
        try {
            // 创建PutObjectRequest对象。
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, file);
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setObjectAcl(CannedAccessControlList.PublicRead);
            putObjectRequest.setMetadata(metadata);


            // 上传文件。
            PutObjectResult result = ossClient.putObject(putObjectRequest);
            // 拼接文件在线访问地址
            String fileUrl = "https://" + bucketName + "." + endpoint.replace("https://", "") + "/" + objectName;

            return Result.success(fileUrl);
        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message:" + oe.getErrorMessage());
            System.out.println("Error Code:" + oe.getErrorCode());
            System.out.println("Request ID:" + oe.getRequestId());
            System.out.println("Host ID:" + oe.getHostId());
            return Result.error("文件上传失败：" + oe.getErrorMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("系统异常：" + e.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
    }

    public Result uploadVideo(MultipartFile multipartFile) {
        // 将 MultipartFile 转换成临时 File
        File tempFile = null;
        try {
            String originalFilename = multipartFile.getOriginalFilename();
            // 用系统临时目录创建临时文件
            tempFile = File.createTempFile("upload-", originalFilename);
            multipartFile.transferTo(tempFile);

            // 使用已有的 uploadVideo(File file) 上传
            Result result = uploadVideo(tempFile);

            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("文件上传失败：" + e.getMessage());
        } finally {
            // 删除临时文件
            if (tempFile != null && tempFile.exists()) {
                tempFile.delete();
            }
        }
    }

//
//public static void main(String[] args) throws Exception {
//    // Endpoint以华东1（杭州）为例，其它Region请按实际情况填写。
//    String endpoint = "https://oss-cn-shanghai.aliyuncs.com";
//    // 从环境变量中获取访问凭证。运行本代码示例之前，请确保已设置环境变量OSS_ACCESS_KEY_ID和OSS_ACCESS_KEY_SECRET。
//    EnvironmentVariableCredentialsProvider credentialsProvider = CredentialsProviderFactory.newEnvironmentVariableCredentialsProvider();
//    // 填写Bucket名称，例如examplebucket。
//    String bucketName = "roomyyt";
//    // 填写Object完整路径，完整路径中不能包含Bucket名称，例如exampledir/exampleobject.txt。
//    String objectName = "video/videotest.mp4";
//    // 填写Bucket所在地域。以华东1（杭州）为例，Region填写为cn-hangzhou。
//    String region = "cn-shanghai";
//    String filePath= "E:\\bishe\\music-new\\video\\1.mp4";
//
//
//    // 创建OSSClient实例。
//    ClientBuilderConfiguration clientBuilderConfiguration = new ClientBuilderConfiguration();
//    clientBuilderConfiguration.setSignatureVersion(SignVersion.V4);
//    OSS ossClient = OSSClientBuilder.create()
//            .endpoint(endpoint)
//            .credentialsProvider(credentialsProvider)
//            .clientConfiguration(clientBuilderConfiguration)
//            .region(region)
//            .build();
//
//    try {
//        // 创建PutObjectRequest对象。
//        PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, new File(filePath));
//        ObjectMetadata metadata = new ObjectMetadata();
//        metadata.setObjectAcl(CannedAccessControlList.PublicRead);
//        putObjectRequest.setMetadata(metadata);
//
//
//        // 上传文件。
//        PutObjectResult result = ossClient.putObject(putObjectRequest);
//        System.out.println(result);
//    } catch (OSSException oe) {
//        System.out.println("Caught an OSSException, which means your request made it to OSS, "
//                + "but was rejected with an error response for some reason.");
//        System.out.println("Error Message:" + oe.getErrorMessage());
//        System.out.println("Error Code:" + oe.getErrorCode());
//        System.out.println("Request ID:" + oe.getRequestId());
//        System.out.println("Host ID:" + oe.getHostId());
//    } finally {
//        if (ossClient != null) {
//            ossClient.shutdown();
//        }
//    }
//}
}
