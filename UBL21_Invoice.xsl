<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet 
		version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:ubl="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
		xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
		xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
		exclude-result-prefixes="ubl">

<!-- XSL conversie naar HTML tables voor UBL 2.1 Factuur (Invoice) -->
<xsl:output method="html"/>

<xsl:template match="/">
<html> 
<body>

  <h2>Invoice</h2>
  <!-- header gegevens verticaal in een tabel -->
  <table id="invoice">
    <caption>Invoice</caption>
	<tbody>
    <xsl:for-each select="ubl:Invoice">
    <tr> <th>cbc:ID</th>         <td><xsl:value-of select="cbc:ID"/>      </td> </tr>
    <tr> <th>cbc:IssueDate</th>  <td><xsl:value-of select="cbc:IssueDate"/>       </td> </tr>
    <tr> <th>cbc:StartDate</th>  <td><xsl:value-of select="cac:InvoicePeriod/cbc:StartDate"/>         </td> </tr>
    <tr> <th>cbc:EndDate</th>    <td><xsl:value-of select="cac:InvoicePeriod/cbc:EndDate"/>         </td> </tr>
    <tr> <th>Supplier_Name</th>  <td><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name"/>     </td> </tr>
    <tr> <th>Customer_Name</th>  <td><xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cac:PartyName/cbc:Name"/>    </td> </tr>
    <tr> <th>Payable_Amount</th> <td><xsl:value-of select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
									 <xsl:text> </xsl:text>
									 <xsl:value-of select="cac:LegalMonetaryTotal/cbc:PayableAmount"/> </td> </tr>
    </xsl:for-each>
	</tbody>
  </table>
	
						<!-- InvoiceLine -->
  <h2>InvoiceLine</h2>
  <table id="invoiceline">
    <caption>InvoiceLine</caption>
	<thead>
    <tr>
      <th style="text-align:left">ID</th>
      <th style="text-align:left">Quantity</th>
      <th style="text-align:left">Item_Description</th>
      <th style="text-align:left">Price</th>
      <th style="text-align:left">LineExtensionAmount</th>
    </tr>
	</thead>
	<tbody>
    <xsl:for-each select="ubl:Invoice/cac:InvoiceLine">
    <tr>
      <td><xsl:value-of select="cbc:ID"/></td>
      <td><xsl:value-of select="cbc:InvoicedQuantity"/></td>
      <td><xsl:value-of select="cac:Item/cbc:Description"/></td>
      <td><xsl:value-of select="cac:Price"/></td>
      <td><xsl:value-of select="cbc:LineExtensionAmount/@currencyID"/>
		  <xsl:text> </xsl:text>
		  <xsl:value-of select="cbc:LineExtensionAmount"/></td>
    </tr>
    </xsl:for-each>
	</tbody>
  </table>
	<!-- Einde van tabel InvoiceLine -->
	
  
</body>
</html>

<!-- einde HTML document -->
</xsl:template>
</xsl:stylesheet>

