package com.metalineage.metadata;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import org.jsoup.nodes.Element;

public class test {
    public static void main(String[] args) {
        String html = "现场返回的html代码";

        Document doc = Jsoup.parse(html);

        Elements rows = doc.select("table tbody tr");

        for (Element row : rows) {
            Elements tds = row.select("td");
            if (tds.size() > 4) { // 确保有足够的列
                String bytesIn = tds.get(4).text().replaceAll("\\D", ""); // 提取并清理Bytes In数据
                String bytesOut = tds.get(5).text().replaceAll("\\D", ""); // 提取并清理Bytes Out数据
                System.out.print("Bytes In: " + bytesIn+"\t");
                System.out.println("Bytes Out: " + bytesOut);
                }
            }
        }
    }
