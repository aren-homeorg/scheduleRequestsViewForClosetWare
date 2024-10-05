SELECT
	sr.rowguid,
    sr.location_id as FID,
    sr.submitted_time as CurrentDate,
    sr.name as ContactName,
    sr.firstname as FirstName,
    sr.lastname as LastName,
    sr.address1 as Address,
    case when sr.address2 is not null then sr.address2 else '' end as cross_street,
    sr.city as City,
    sr.state as State,
    sr.zip as Zip,
    sr.phone as DaytimePhone,
    sr.secondary_phone as EveningPhone,
    sr.email_address as email_address,
    case when srai_wic.id is null and srai_bc.id is null and srai_kc.id is null then '' else 'XX' end as Closet,
    case when srai_gc.id is null then '' else 'XX' end as Garage,
    case when srai_ho.id is null then '' else 'XX' end as HomeOffice,
    case when srai_pa.id is null then '' else 'XX' end as Pantry,
    case when srai_wb.id is null then '' else 'XX' end as Wallbed,
    case when srai_sd.id is null then '' else 'XX' end as SlidingDoor,
    case when srai_gf.id is null and srai_mc.id is null and srai_ot.id is null then '' else 'XX' end as Other,
    case when srai_ot.id is null then '' else (case when srai_ot.area_interest_other is null then '' else srai_ot.area_interest_other end) end as OtherInterest,
    DATE_FORMAT(sr.appt_date_first_choice, '%Y-%m-%d') as ApptDateFirstChoice,
    case when sr.appt_time_first_choice is null then 'Other' else TIME_FORMAT(sr.appt_time_first_choice, '%l:%i %p') end as ApptTimeFirstChoice,
    DATE_FORMAT(sr.appt_date_second_choice, '%Y-%m-%d') as ApptDateSecondChoice,
    case when sr.appt_time_second_choice is null then 'Other' else TIME_FORMAT(sr.appt_time_second_choice, '%l:%i %p') end as ApptTimeSecondChoice,
    sr.comments as Comments,
    ifnull(concat(cast(sr.location_id as char(20) charset utf8),'	',
			convert(loc.location using utf8),'	',
			convert(loc.name using utf8),'	',
			convert(loc.address using utf8),'	',
			convert(loc.address1 using utf8),'	',
			convert(loc.city using utf8),'	',
			convert(loc.state using utf8),'	',
			convert(loc.zip using utf8),'	',
			convert(loc.phone_area_code using utf8),'	',
			convert(loc.phone using utf8),'	',
			convert(loc.fax_area_code using utf8),'	',
			convert(loc.fax using utf8),'	',
			convert(locem.email using utf8)),'') AS FranchiseInfo,
    sr.http_client_ip as HTTP_CLIENT_IP,
    sr.request_uri as REQUEST_UTI,
    case when par.m_code is null then '' else par.m_code end as HTTP_REFERER,
    sr.landing_url as LANDING_URL,
    0 as STATUS,
    case when par.m_code is null then '' else par.m_code end as MarketCodeURL,
    sr.country,
    par.p_fbclid as fbclid,
    par.p_gclid as gclid,
    par.p_msclkid as msclkid,
    par.p_epik as epik,
    par.p_cto_pld as cto_pld
FROM 
    schedule_requests as sr 
    left join schedule_request_area_interests as srai_wic on sr.id = srai_wic.schedule_request_id and srai_wic.area_interest_id = 1
    left join schedule_request_area_interests as srai_bc on sr.id = srai_bc.schedule_request_id and srai_bc.area_interest_id = 3
    left join schedule_request_area_interests as srai_kc on sr.id = srai_kc.schedule_request_id and srai_kc.area_interest_id = 5
    left join schedule_request_area_interests as srai_gc on sr.id = srai_gc.schedule_request_id and srai_gc.area_interest_id = 2
    left join schedule_request_area_interests as srai_ho on sr.id = srai_ho.schedule_request_id and srai_ho.area_interest_id = 4
    left join schedule_request_area_interests as srai_pa on sr.id = srai_pa.schedule_request_id and srai_pa.area_interest_id = 6
    left join schedule_request_area_interests as srai_wb on sr.id = srai_wb.schedule_request_id and srai_wb.area_interest_id = 7
    left join schedule_request_area_interests as srai_la on sr.id = srai_la.schedule_request_id and srai_la.area_interest_id = 8
    left join schedule_request_area_interests as srai_sd on sr.id = srai_sd.schedule_request_id and srai_sd.area_interest_id = 9
    left join schedule_request_area_interests as srai_gf on sr.id = srai_gf.schedule_request_id and srai_gf.area_interest_id = 10
    left join schedule_request_area_interests as srai_mc on sr.id = srai_mc.schedule_request_id and srai_mc.area_interest_id = 11
    left join schedule_request_area_interests as srai_ot on sr.id = srai_ot.schedule_request_id and srai_ot.area_interest_id = 12
    left join locations as loc on sr.location_id = loc.id
    left join location_emails as locem on loc.id = locem.location_id
    left join url_parameters par on sr.id = par.table_id and sr.form_id = par.form_id



