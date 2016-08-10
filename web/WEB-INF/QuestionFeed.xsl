<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : QuestionFeed.xsl
    Created on : August 5, 2016, 5:38 PM
    Author     : lethanhtan
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:date="http://exslt.org/dates-and-times">    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
            
    <xsl:template match="/">                    
        <xsl:apply-templates />
    </xsl:template>
            
    <xsl:template match="Questions">
        <xsl:for-each select="tblQuestionDTO">
            <div class="div-post">                                             
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
                    <xsl:variable name="Id" select="id" />
                    <a href="ProcessServlet?btAction=Answer&amp;questionId={$Id}">
                        <xsl:value-of select="title" /> 
                    </a>
                </span>                                  
            </div>
        </xsl:for-each>
    </xsl:template>
    

 
</xsl:stylesheet>
