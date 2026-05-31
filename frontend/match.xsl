<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/match">
        <html lang="es">
        <head>
            <meta charset="UTF-8"/>
            <title>LoveCode - Ficha de Match</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background: #f9f9f9;
                    display: flex;
                    justify-content: center;
                    padding: 2rem;
                    margin: 0;
                }
                .ficha {
                    background: #fff;
                    border: 1px solid #ddd;
                    border-radius: 12px;
                    padding: 2rem;
                    max-width: 600px;
                    width: 100%;
                    box-shadow: 0 4px 12px rgba(0,0,0,.08);
                }
                h1 { color: #e05c5c; text-align: center; margin-bottom: .4rem; }
                .fecha { text-align: center; font-size: 12px; color: #aaa; margin-bottom: 2rem; }
                .usuarios { display: flex; gap: 1.5rem; margin-bottom: 2rem; }
                .usuario {
                    flex: 1;
                    background: #f9f9f9;
                    border: 1px solid #eee;
                    border-radius: 8px;
                    padding: 1rem;
                    text-align: center;
                }
                .usuario h3 { color: #e05c5c; margin-bottom: .5rem; font-size: 1rem; }
                .usuario p  { font-size: 12px; color: #777; margin-bottom: .8rem; }
                .tags { display: flex; flex-wrap: wrap; gap: 5px; justify-content: center; }
                .tag {
                    background: #f4f6fb;
                    color: #555;
                    border: 1px solid #ddd;
                    font-size: 11px;
                    padding: 3px 9px;
                    border-radius: 20px;
                }
                .tag.verde { background: #eafaf1; color: #1e8449; border-color: #a9dfbf; }
                .comunes { text-align: center; }
                .comunes h3 { color: #555; margin-bottom: 1rem; font-size: .95rem; }
                .volver {
                    display: block;
                    text-align: center;
                    margin-top: 1.5rem;
                    color: #e05c5c;
                    font-size: 13px;
                    text-decoration: none;
                }
            </style>
        </head>
        <body>
            <div class="ficha">
                <h1>Es un Match! ❤️</h1>
                <p class="fecha">Fecha: <xsl:value-of select="fecha"/></p>

                <div class="usuarios">

                    <div class="usuario">
                        <h3><xsl:value-of select="usuario1/nombre"/></h3>
                        <p><xsl:value-of select="usuario1/descripcion"/></p>
                        <div class="tags">
                            <xsl:for-each select="usuario1/tecnologias/tecnologia">
                                <span class="tag">
                                    <xsl:value-of select="."/>
                                </span>
                            </xsl:for-each>
                        </div>
                    </div>

                    <div class="usuario">
                        <h3><xsl:value-of select="usuario2/nombre"/></h3>
                        <p><xsl:value-of select="usuario2/descripcion"/></p>
                        <div class="tags">
                            <xsl:for-each select="usuario2/tecnologias/tecnologia">
                                <span class="tag">
                                    <xsl:value-of select="."/>
                                </span>
                            </xsl:for-each>
                        </div>
                    </div>

                </div>

                <div class="comunes">
                    <h3>Tecnologias en comun</h3>
                    <div class="tags">
                        <xsl:choose>
                            <xsl:when test="tecnologias_comunes/tecnologia">
                                <xsl:for-each select="tecnologias_comunes/tecnologia">
                                    <span class="tag verde">
                                        <xsl:value-of select="."/>
                                    </span>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="tag">Ninguna tecnologia en comun de momento</span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </div>

                <a class="volver" href="perfiles.html">← Volver a perfiles</a>
            </div>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
