package com.pzy.common.exception;

import com.pzy.utils.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.io.IOException;

/**
 * @Author Nice
 * @Date 2021/7/8 17:31
 * 全局异常捕获
 */
@Slf4j
@RestControllerAdvice
public class GlobalExcepitonHandler {
    /**
     * 处理Assert的异常
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = IllegalArgumentException.class)
    public Result handler(IllegalArgumentException e) throws IOException {
        log.error("Assert异常:-------------->{}",e.getMessage());
        return Result.fail(e.getMessage());
    }
//    /**
//     * @Validated 校验错误异常处理
//     */
//    @ResponseStatus(HttpStatus.BAD_REQUEST)
//    @ExceptionHandler(value = MethodArgumentNotValidException.class)
//    public Result handler(MethodArgumentNotValidException e) throws IOException {
//        log.error("运行时异常:-------------->",e);
//        BindingResult bindingResult = e.getBindingResult();
//        ObjectError objectError = bindingResult.getAllErrors().stream().findFirst().get();
//        return Result.fail(objectError.getDefaultMessage());
//    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = RuntimeException.class)
    public Result handler(RuntimeException e) throws IOException {
        log.error("运行时异常:-------------->",e);
        return Result.fail(e.getMessage());
    }

}
