<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : AnswerFeed.xsl
    Created on : August 7, 2016, 1:51 AM
    Author     : lethanhtan
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
                        
    <xsl:template match="tblQuestionDTO">
        <div class="question">
            <span class="owner" >
                <xsl:value-of select="username" /> 
            </span>
            <br/>
            
            <span class="time" >                                    
                <xsl:variable name="year" select="substring(date,0,5)"/>
                <xsl:variable name="monthNbr" select="substring(date,6,2)"/>                    
                <xsl:variable name="day" select="substring(date,9,2)"/>
                <xsl:variable name="hour" select="substring(date,12,2)" />
                <xsl:variable name="minute" select="substring(date,15,2)" />                    
                <xsl:value-of select="concat($day,'-',$monthNbr,'-',$year, ' at ' ,$hour,':', $minute)"/>                                                
            </span>
            <br/>
            
            <br/>
            <span class="tilte">
                <xsl:value-of select="title" /> 
            </span>  
        </div>
                        
    </xsl:template>    
    
    <xsl:template match="tblAnswerDTO">
        <br/>
        <div class="answer">
            <div class="user-answer" style="padding-left:20px">
                <span class="owner" >
                    <xsl:value-of select="username" />
                </span>
                :
                <span class="tilte" style="width:100%;">
                    <xsl:value-of select="content" />
                </span>
            </div>            
        </div>
    </xsl:template>        
    
</xsl:stylesheet>
