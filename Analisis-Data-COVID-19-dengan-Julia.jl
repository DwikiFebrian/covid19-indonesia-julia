### A Pluto.jl notebook ###
# v0.20.8

using Markdown
using InteractiveUtils

# ╔═╡ 5ae269a7-c3e7-45c5-a019-2119ec9e96b8
using Pkg

# ╔═╡ de6ae03d-60be-43b2-8634-d6a62f8ff1ef
Pkg.add("Downloads")

# ╔═╡ ca194176-b4aa-41ae-81dc-8b5ed935c712
Pkg.add("CSV");

# ╔═╡ 8a55c368-e89a-4a1d-ae8c-b5a90dd0a1ef
Pkg.add("DataFrames");

# ╔═╡ 066e2cf5-59f4-4912-a158-c9a54463a587
Pkg.add("Interact")

# ╔═╡ 72c47314-e481-417a-b277-f5c6a8454a36
Pkg.add("Plots");

# ╔═╡ f0f67778-c8e2-4dcd-9261-149f06595574
using CSV, DataFrames, Interact

# ╔═╡ e6de3f93-df33-484a-b5fc-ebe3ec4bf41e
using Plots

# ╔═╡ a9a2a70f-1da3-45b4-b1d8-26102171cebf
using Dates

# ╔═╡ 453aec40-ba1c-48a1-aa02-70ab2c9dbad1
md"## Codid-19 Data Analysis"

# ╔═╡ 162884f9-1be7-4752-bdc8-7eb1a1378fc2
md"### Prepare the Data"

# ╔═╡ 25ba02b9-bbb7-42ca-950c-8c5099f2e4cf
url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/refs/heads/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

# ╔═╡ 244e159a-eeda-4513-b147-07275372ef21
download(url, "covid_data.csv")

# ╔═╡ 48dea0c7-b852-4938-a02a-6d5065c9a84a
readdir()

# ╔═╡ b1d89f5a-72a7-4e7b-b00d-916bde1c8769
df = CSV.read("covid_data.csv", DataFrame)

# ╔═╡ ea1be406-1830-44e7-aad0-be155bd02365
rename!(df, 2 => "country")

# ╔═╡ e7ab7bc9-bafa-4082-a101-197824d25380
md"## Extract the Data"

# ╔═╡ 6c3f139e-d8fd-4709-b7e6-36c8f59ae03e
negara = unique(collect(df[:, 2]))

# ╔═╡ babdffad-1fa3-4ca5-b1cd-52a33ccb6e06
negara_i = [startswith(country, "I") for country in negara]

# ╔═╡ e8fcdc63-b727-44d4-84d0-0f620e32251b
ind_idx = findfirst(negara .== "Indonesia")

# ╔═╡ 6ee52be6-7bcf-4589-a65c-f44da8bb5a54
ind_df = convert(Vector, df[:,ind_idx])

# ╔═╡ 19c795e7-3338-44d2-9732-579356e691a7
plot(ind_df, label="Banyaknya Kasus")

# ╔═╡ 47b1b97e-ce7e-4a61-b696-8f3b641474d1
savefig("plotcovid1")

# ╔═╡ 61586f4e-e2a2-4f16-847a-cae6d59168bc
filtered_df = df[df.country .== "Indonesia", :]

# ╔═╡ fd07664e-019e-4d9a-b844-96ce844dea62
data_indo =  collect(filtered_df[1, 5:end])

# ╔═╡ f49e5265-14dd-4e4b-b1e6-110474f50efb
length(data_indo)

# ╔═╡ cea6c9de-6649-4bca-b63f-f440b3d3268e
col_names = String.(names(filtered_df))

# ╔═╡ 7f2c109b-4dc4-4e3e-849a-9775087a400d
tanggal = col_names[5:end]

# ╔═╡ a6bb787c-4b4f-4fd4-8f05-00fe73a7054d
format = Dates.DateFormat("m/d/y")

# ╔═╡ 8f664f88-2de9-45da-9c05-38fc2ca457c5
date = parse.(Date, tanggal, format) .+ Year(2000)

# ╔═╡ b81388d3-cc9a-4493-84e9-39df87c0fecf
date

# ╔═╡ 1b04340a-67cb-4752-b67d-dccf5eed058f
md"## Visualisation"

# ╔═╡ 63f48301-1631-4fa0-8d4c-c9ecea71ce7c
length(date)

# ╔═╡ 4461c854-4f73-4d62-b0d3-fb8c41319df0
plot(tanggal, data_indo, xrotation = 45, label = "Data Indonesia", size=(800,600), lw =3);

# ╔═╡ 98ac8340-a132-4bf6-ba26-f4c3d28c62e5
xlabel!("tanggal");

# ╔═╡ c2590c4f-bcb7-45b0-a835-83d7d1bb4428
ylabel!("kasus terkonfirmasi");

# ╔═╡ b1c90abd-5c80-4013-8f1d-2617b0ec127d
title!("Karva Kasus COVID-19 di Indonesia")

# ╔═╡ bb37e37a-16fa-475a-9ad7-70ee4f8d75f5
savefig("plotcovid2")

# ╔═╡ 742740b0-2a9a-4b1d-9b74-007665c8cf0e
md"## Animate"

# ╔═╡ fd479010-3891-43e1-bdf7-f1dbda6572aa
date_labels = Dates.format.(date, DateFormat("dd u yyyy"))

# ╔═╡ 1be7f496-2ae1-4fdb-89bd-26066b8e4b2f
anim = @animate for i in 1:20:length(date)
    plot(1:i, data_indo[1:i];
         lw=4,
         label="Data Indonesia",
         xlabel="Tanggal",
         ylabel="Kasus",
         title="Perkembangan Kasus",
         xrotation=45,
		 xticks=(1:200:length(date), date_labels),
		 size=(900,750))
end

# ╔═╡ fcc3f1ec-544c-49e3-9b2b-34c38167232d
gif(anim, "kasus_indo.gif", fps=10)

# ╔═╡ Cell order:
# ╠═453aec40-ba1c-48a1-aa02-70ab2c9dbad1
# ╠═5ae269a7-c3e7-45c5-a019-2119ec9e96b8
# ╠═de6ae03d-60be-43b2-8634-d6a62f8ff1ef
# ╠═162884f9-1be7-4752-bdc8-7eb1a1378fc2
# ╠═25ba02b9-bbb7-42ca-950c-8c5099f2e4cf
# ╠═244e159a-eeda-4513-b147-07275372ef21
# ╠═ca194176-b4aa-41ae-81dc-8b5ed935c712
# ╠═8a55c368-e89a-4a1d-ae8c-b5a90dd0a1ef
# ╠═48dea0c7-b852-4938-a02a-6d5065c9a84a
# ╠═066e2cf5-59f4-4912-a158-c9a54463a587
# ╠═f0f67778-c8e2-4dcd-9261-149f06595574
# ╠═b1d89f5a-72a7-4e7b-b00d-916bde1c8769
# ╠═ea1be406-1830-44e7-aad0-be155bd02365
# ╠═e7ab7bc9-bafa-4082-a101-197824d25380
# ╠═6c3f139e-d8fd-4709-b7e6-36c8f59ae03e
# ╠═babdffad-1fa3-4ca5-b1cd-52a33ccb6e06
# ╠═e8fcdc63-b727-44d4-84d0-0f620e32251b
# ╠═6ee52be6-7bcf-4589-a65c-f44da8bb5a54
# ╠═72c47314-e481-417a-b277-f5c6a8454a36
# ╠═e6de3f93-df33-484a-b5fc-ebe3ec4bf41e
# ╠═19c795e7-3338-44d2-9732-579356e691a7
# ╠═47b1b97e-ce7e-4a61-b696-8f3b641474d1
# ╠═61586f4e-e2a2-4f16-847a-cae6d59168bc
# ╠═fd07664e-019e-4d9a-b844-96ce844dea62
# ╠═f49e5265-14dd-4e4b-b1e6-110474f50efb
# ╠═cea6c9de-6649-4bca-b63f-f440b3d3268e
# ╠═7f2c109b-4dc4-4e3e-849a-9775087a400d
# ╠═a9a2a70f-1da3-45b4-b1d8-26102171cebf
# ╠═a6bb787c-4b4f-4fd4-8f05-00fe73a7054d
# ╠═8f664f88-2de9-45da-9c05-38fc2ca457c5
# ╠═b81388d3-cc9a-4493-84e9-39df87c0fecf
# ╠═1b04340a-67cb-4752-b67d-dccf5eed058f
# ╠═63f48301-1631-4fa0-8d4c-c9ecea71ce7c
# ╠═4461c854-4f73-4d62-b0d3-fb8c41319df0
# ╠═98ac8340-a132-4bf6-ba26-f4c3d28c62e5
# ╠═c2590c4f-bcb7-45b0-a835-83d7d1bb4428
# ╠═b1c90abd-5c80-4013-8f1d-2617b0ec127d
# ╠═bb37e37a-16fa-475a-9ad7-70ee4f8d75f5
# ╠═742740b0-2a9a-4b1d-9b74-007665c8cf0e
# ╠═fd479010-3891-43e1-bdf7-f1dbda6572aa
# ╠═1be7f496-2ae1-4fdb-89bd-26066b8e4b2f
# ╠═fcc3f1ec-544c-49e3-9b2b-34c38167232d
