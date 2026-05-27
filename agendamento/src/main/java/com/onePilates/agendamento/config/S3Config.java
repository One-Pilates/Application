package com.onePilates.agendamento.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.AwsSessionCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3ClientBuilder;

import software.amazon.awssdk.regions.Region;
import java.net.URI;

@Configuration
public class S3Config {
    @Value("${aws.region}")
    private String region;

    @Value("${aws.accessKey}")
    private String accessKey;

    @Value("${aws.secretKey}")
    private String secretKey;

        @Value("${aws.sessionToken:}")
        private String sessionToken;

    @Value("${aws.s3.endpoint}")
    private String endpoint;

    @Bean
    public S3Client s3Client() {

        S3ClientBuilder builder = S3Client.builder()
                .region(Region.of(region))
                .credentialsProvider(StaticCredentialsProvider.create(
                        (sessionToken != null && !sessionToken.isBlank())
                                ? AwsSessionCredentials.create(accessKey, secretKey, sessionToken)
                                : AwsBasicCredentials.create(accessKey, secretKey)
                ));

        if (endpoint != null && !endpoint.isEmpty()) {
            builder.endpointOverride(URI.create(endpoint))
                    .forcePathStyle(true);
        }

        return builder.build();
    }
}
