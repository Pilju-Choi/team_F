package org.zerock.domain;

import lombok.Data;

@Data
public class WordVO {
	private int wordId;
	private String wordSpell;
	private String wordMean;
	private int wordLevel;
	
	//몇 일차 단어인지
	private int wordDay; 
}