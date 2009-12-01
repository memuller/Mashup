module AnalyticHelper
	
	def clean_tag tag
		tag.gsub("+"," ").gsub("ga:pageTitle=",nil.to_s).gsub("Mashup Canção Nova — cobertura online dos eventos da Canção Nova",nil.to_s).gsub("— Mashup Canção Nova",nil.to_s).gsub("Online Canção Nova",nil.to_s).gsub("— Mashup multimídia para a cobertura online dos eventos",nil.to_s).gsub("Mashup Canção Nova",nil.to_s).strip 
	end
end
