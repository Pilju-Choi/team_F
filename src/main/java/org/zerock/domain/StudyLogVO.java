package org.zerock.domain;

import java.util.Date;
import lombok.Data;

@Data
public class StudyLogVO {
	private int logId;
	private String userId;
	private int wordId;
	private String isCorrect;
	private Date studyDate;
}