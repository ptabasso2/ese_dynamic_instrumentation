package com.datadog.pej.front;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

//@RequestMapping("/upstream")
@RestController
public class BasicController {

    private static final Logger LOGGER = LoggerFactory.getLogger(BasicController.class);

    @Autowired
    RestTemplate restTemplate;

    @Value("#{environment['url'] ?: 'http://localhost:8088'}")
    private String url;

    //@RequestMapping("/second/{id}/third")
    @RequestMapping("*/*/*/*")
    public String upstream() {
        int randomValue = 5 + (int)(Math.random() * ((10 - 5) + 1));
        processingData(randomValue);
        Quote quote = restTemplate.getForObject(url + "/downstream", Quote.class);
        processingQuote(quote);
        postProcessingQuote(quote);
        LOGGER.info("PathVariable value: ");
        return quote.toString()+"\n";
    }

    public String processingQuote(Quote quote){
        return quote.getType();
    }

    public Quote postProcessingQuote(Quote quote){
        return quote;
    }

    public String processingData(int val){
        String localValue;
        localValue = "Alpha" + val;
        return localValue;
    }


}