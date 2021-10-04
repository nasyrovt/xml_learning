<?xml version="1.0" encoding="UTF-8" ?>

<!--
    Document   : afficheEchecs.xsl
    Created on : 9 février 2003, 11:23
    Author     : vincent
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ech="http://ujf-grenoble.fr/echec">
   
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
   <!-- template rule matching source root element -->
   <xsl:template match="/">
     <html>
       <head>
         <title><xsl:value-of select="ech:echec/ech:commentaire"/></title>
       </head>
       <body> 
         <center>
         <xsl:choose>
           <xsl:when test="ech:echec">
           </xsl:when>
           <xsl:when test="ech:piece">
           </xsl:when>
            <xsl:when test="/*/ech:piece">
           </xsl:when>           
           <xsl:otherwise>
             <h1>fichier source non conforme, élément racine 
               inconnu dans ce vocabulaire.
             </h1>
           </xsl:otherwise>
         </xsl:choose>
         <h3><xsl:value-of select="ech:echec/ech:commentaire"/></h3>
         
         <table>
           <xsl:call-template name="affiche-lignes">
             <xsl:with-param name="lignes" select="'8,7,6,5,4,3,2,1,*,'"/>
             <xsl:with-param name="couleur" select="1"/>
           </xsl:call-template>
         </table>
         </center>
       </body>
      
     </html>
   </xsl:template>

   <xsl:template name="affiche-lignes">
     <xsl:param name="lignes" />
     <xsl:param name="couleur" />
     
     <xsl:if test="string-length($lignes)>1">
       <xsl:call-template name="affiche-ligne">
         <xsl:with-param name="couleur" select="$couleur"/>
         <xsl:with-param name="ligne" 
                         select="substring-before($lignes,',')"/>
       </xsl:call-template>
     </xsl:if>
     <xsl:if test="string-length($lignes)>3">
       <xsl:call-template name="affiche-lignes">
         <xsl:with-param name="couleur" select="1-$couleur"/>
         <xsl:with-param name="lignes" 
                         select="substring-after($lignes,',')"/>
       </xsl:call-template>
     </xsl:if>
   </xsl:template>
   
  <xsl:template name="affiche-ligne">
     <xsl:param name="couleur" />
     <xsl:param name="ligne" />
    <tr>
      <xsl:call-template name="affiche-colonnes">
        <xsl:with-param name="ligne" select="$ligne"/>
        <xsl:with-param name="couleur" select="$couleur"/>
        <xsl:with-param name="colonnes" select="'*,A,B,C,D,E,F,G,H,'"/>
      </xsl:call-template>  
    </tr>
  </xsl:template>    
  
  <xsl:template name="affiche-colonnes">
     <xsl:param name="ligne" />
     <xsl:param name="colonnes" />
     <xsl:param name="couleur" />
     
     <xsl:if test="string-length($colonnes)>1">
       <xsl:call-template name="affiche-colonne">
         <xsl:with-param name="couleur" select="$couleur"/>
         <xsl:with-param name="ligne" select="$ligne"/>
         <xsl:with-param name="colonne" 
                         select="substring-before($colonnes,',')"/>
       </xsl:call-template>
     </xsl:if>
     <xsl:if test="string-length($colonnes)>3">
       <xsl:call-template name="affiche-colonnes">
         <xsl:with-param name="couleur" select="1-$couleur"/>
         <xsl:with-param name="ligne" select="$ligne"/>
         <xsl:with-param name="colonnes" 
                         select="substring-after($colonnes,',')"/>
       </xsl:call-template>
     </xsl:if>
   </xsl:template>
  
  <xsl:template name="affiche-colonne">
     <xsl:param name="ligne" />
     <xsl:param name="colonne" />
     <xsl:param name="couleur" />
     
    
      <xsl:choose>
        <xsl:when test="$ligne='*'">
          <xsl:choose>
            <xsl:when test="$colonne!='*'">
              <td align="middle">
                <xsl:value-of select="$colonne"/>
              </td>
            </xsl:when>
            <xsl:otherwise>
              <td></td>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="$colonne='*'">
          <td width="20">
            <xsl:value-of select="$ligne"/>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td width="49" height="49">
            <xsl:attribute name="bgcolor">
                <xsl:choose>
                  <xsl:when test="$couleur=0">
                    <xsl:text>#ffffff</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>#aaaaff</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
             </xsl:attribute>
             <xsl:choose>
                <xsl:when test="/*/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]">
                 <img border="0">
                   <xsl:attribute name="src">jeu/<xsl:value-of select="/*/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]/ech:nom"/>_blanc.gif</xsl:attribute>
                   <xsl:attribute name="alt"><xsl:value-of select="/*/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]/ech:nom"/> [blanc]</xsl:attribute>
                 </img>
               </xsl:when>             
               <xsl:when test="/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]">
                 <img border="0">
                   <xsl:attribute name="src">jeu/<xsl:value-of select="/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]/ech:nom"/>_blanc.gif</xsl:attribute>
                   <xsl:attribute name="alt"><xsl:value-of select="/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]/ech:nom"/> [blanc]</xsl:attribute>
                 </img>
               </xsl:when>
               <xsl:when test="/ech:echec/ech:piecesBlanches/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]">
                 <img border="0">
                   <xsl:attribute name="src">jeu/<xsl:value-of select="/ech:echec/ech:piecesBlanches/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]/ech:nom"/>_blanc.gif</xsl:attribute>
                   <xsl:attribute name="alt"><xsl:value-of select="/ech:echec/ech:piecesBlanches/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]/ech:nom"/> [blanc]</xsl:attribute>
                 </img>
               </xsl:when>
               <xsl:when test="/ech:echec/ech:piecesNoires/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]">
                 <img border="0">
                   <xsl:attribute name="src">jeu/<xsl:value-of select="/ech:echec/ech:piecesNoires/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]/ech:nom"/>_noir.gif</xsl:attribute>
                   <xsl:attribute name="alt"><xsl:value-of select="/ech:echec/ech:piecesNoires/ech:piece[(ech:position/ech:ligne/text()=$ligne)and(ech:position/ech:colonne/text()=$colonne)]/ech:nom"/> [noir]</xsl:attribute>
                 </img>
               </xsl:when>
               <xsl:otherwise>
               </xsl:otherwise>
             </xsl:choose>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      
  </xsl:template>   
</xsl:stylesheet> 
