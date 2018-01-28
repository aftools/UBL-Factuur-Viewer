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

	<xsl:for-each select="ubl:Invoice">
  
		<h2>Afzender</h2>
		<!-- Afzender gegevens verticaal in een tabel -->
		<table id="afzender" class="afzender">
		<caption>Afzender</caption>
		<tbody>
		<tr> <th>Naam </th> <td><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name"/>     </td> </tr>
		<tr> <th>Adres</th> <td><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName"/>     </td> </tr>
		<tr> <th>     </th> <td><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>  
								<xsl:text>  </xsl:text>
								<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName"/>     </td> </tr>

		<tr> <th>Tel  </th> <td><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone"/>     </td> </tr>
		<tr> <th>email</th> <td><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>     </td> </tr>

		<!-- IBAN -->
		<tr> <th><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID/@schemeID"/>  </th>
							<td><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/>     </td> </tr>
		<!-- BIC -->
		<tr> <th><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID/@schemeID"/>  </th>
							<td><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>     </td> </tr>

		<tr> <th>KvK-nr</th> <td><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID"/>     </td> </tr>
		<tr> <th>Btw-nr</th> <td><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>     </td> </tr>

		</tbody>
		</table>

		<h2>Aan</h2>
		<!-- Adres gegevens verticaal in een tabel -->
		<table id="aan">
		<caption>Aan</caption>
		<tbody>
		<tr> <th>Naam </th> <td><xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cac:PartyName/cbc:Name"/>     </td> </tr>
		<tr> <th>Adres</th> <td><xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName"/>     </td> </tr>
		<tr> <th>     </th> <td><xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>  
								<xsl:text>  </xsl:text>
								<xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName"/>     </td> </tr>

		</tbody>
		</table>

		<h2>Factuur</h2>
		<!-- Header gegevens verticaal in een tabel -->
		<table id="aan">
		<caption>Factuur</caption>
		<tbody>
		<tr> <th>Factuurnummer: </th>         <td><xsl:value-of select="cbc:ID"/>      </td> </tr>
		<tr> <th>Factuurdatum: </th>  <td><xsl:value-of select="cbc:IssueDate"/>       </td> </tr>
		</tbody>
		</table>

		<!-- InvoiceLine -->
		<h2>InvoiceLine</h2>
		<table id="invoiceline" class="invoiceline" >
		<caption>InvoiceLine</caption>
		<thead>
		<tr>
		  <th style="text-align:left">Regel</th>
		  <th style="text-align:left">Product/dienst</th>
		  <th style="text-align:left">Aantal</th>
		  <th style="text-align:left">Prijs</th>
		  <th style="text-align:left">Bedrag</th>
		  <th style="text-align:left">BTW</th>
		</tr>
		</thead>
		<tbody>
		<xsl:for-each select="cac:InvoiceLine">
		<tr>
		  <td><xsl:value-of select="cbc:ID"/></td>
		  <td><xsl:value-of select="cac:Item/cbc:Description"/></td>
		  <td><xsl:value-of select="cbc:InvoicedQuantity"/></td>
		  <td><xsl:value-of select="cac:Price/cbc:PriceAmount/@currencyID"/>
			  <xsl:text> </xsl:text>
		  <xsl:value-of select="cac:Price/cbc:PriceAmount"/></td>
		  <td><xsl:value-of select="cbc:LineExtensionAmount/@currencyID"/>
			  <xsl:text> </xsl:text>
			  <xsl:value-of select="cbc:LineExtensionAmount"/></td>
		  <td><xsl:value-of select="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent"/></td>
		</tr>
		</xsl:for-each> <!-- InvoiceLine -->

		</tbody>
		</table>
		<!-- Einde van tabel InvoiceLine -->



		<h2>Totaal</h2>
		<!-- Totaal gegevens verticaal in een tabel -->
		<table id="totaal" class="totaal">
		<caption>Totaal</caption>
		<tbody>
		<tr> <td>Totaal exclusief BTW</td> <td><xsl:value-of select="cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount/@currencyID"/>
										 <xsl:text> </xsl:text>
										 <xsl:value-of select="cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"/> </td> </tr>
		<!-- Regel voor elk BTW tarief -->
		<xsl:for-each select="cac:TaxTotal/cac:TaxSubtotal">
			<tr> <td>BTW <xsl:value-of select="cac:TaxCategory/cbc:Percent"/> 
					<xsl:text>% over </xsl:text>
					<xsl:value-of select="cbc:TaxableAmount/@currencyID"/> 
					<xsl:value-of select="cbc:TaxableAmount"/> 
					<xsl:text> = </xsl:text>
					<xsl:value-of select="cbc:TaxAmount/@currencyID"/> 
					<xsl:value-of select="cbc:TaxAmount"/> 
			</td> <td>			</td> </tr>
		</xsl:for-each> <!-- TaxSubtotal -->
		
		
		<tr> <td>Totaal BTW bedrag      </td> <td><xsl:value-of select="cac:TaxTotal/cbc:TaxAmount/@currencyID"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="cac:TaxTotal/cbc:TaxAmount"/>
		</td> </tr>
		<tr> <td>Factuurbedrag</td> <td><xsl:value-of select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
										 <xsl:text> </xsl:text>
										 <xsl:value-of select="cac:LegalMonetaryTotal/cbc:PayableAmount"/> </td> </tr>
		</tbody>
		</table>
		<p><xsl:value-of select="cac:PaymentTerms/cbc:Note"/>Graag betalen binnen 30 dagen netto.</p>





		
		
		
		
		
		
	</xsl:for-each> <!-- Invoice -->
	
  
</body>
</html>

<!-- einde HTML document -->
</xsl:template>
</xsl:stylesheet>

