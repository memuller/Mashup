module HomeHelper
	
		def clean_tag tag
			["ga:pageTitle=", "Mashup", "Canção Nova", "cobertura online dos eventos da", "—", "Online", "multimídia para a cobertura online dos eventos"].each do |text|
				tag = tag.gsub(text,nil.to_s)	
			end	
			tag.gsub("+"," ").strip 
		end
end
