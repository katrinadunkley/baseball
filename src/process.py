import pandas as pd

conversion = {
    "object": "TEXT",
    "float64": "NUMERIC",
    "int64": "INTEGER"
}

tables = {"AllstarFull": "all_star",
          "Appearances": "appearances",
          "AwardsManagers": "manager_award",
          "AwardsPlayers": "player_award",
          "AwardsShareManagers": "manager_award_vote",
          "AwardsSharePlayers": "player_award_vote",
          "Batting": "batting",
          "BattingPost": "batting_post",
          "CollegePlaying": "player_college",
          "Fielding": "fielding",
          "FieldingOF": "fielding_outfield",
          "FieldingPost": "fielding_post",
          "HallOfFame": "hall_of_fame",
          "HomeGames": "home_game",
          "Managers": "manager",
          "ManagersHalf": "manager_half",
          "Master": "player",
          "Parks": "park",
          "Pitching": "pitching",
          "PitchingPost": "pitching_post",
          "Salaries": "salary",
          "Schools": "college",
          "SeriesPost": "postseason",
          "Teams": "team",
          "TeamsFranchises": "team_franchise",
          "TeamsHalf": "team_half"}

sql = """.separator ","

"""

for table in sorted(tables):
    print(table)
    data = pd.read_csv("input/baseballdatabank-master/core/%s.csv" % table, low_memory=False)
    data.columns = [col.replace("ID", "_id") for col in data.columns]
    data.columns = [col.replace("year.key", "year") for col in data.columns]
    data.columns = [col.replace(".key",  "_id") for col in data.columns]
    data.columns = [col.replace(".key",  "_id") for col in data.columns]
    data.columns = [col.replace(".",  "_") for col in data.columns]
    data.columns = [col if col != "2B" else "double" for col in data.columns]
    data.columns = [col if col != "3B" else "triple" for col in data.columns]
    data.columns = [col if col != "gameNum" else "game_num" for col in data.columns]
    data.columns = [col if col != "startingPos" else "starting_pos" for col in data.columns]
    data.columns = [col if col != "pointsWon" else "points_won" for col in data.columns]
    data.columns = [col if col != "pointsMax" else "points_max" for col in data.columns]
    data.columns = [col if col != "votesFirst" else "votes_first" for col in data.columns]
    data.columns = [col if col != "InnOuts" else "inn_outs" for col in data.columns]
    data.columns = [col if col != "VotedBy" else "voted_by" for col in data.columns]
    data.columns = [col if col != "plyrMgr" else "plyr_mgr" for col in data.columns]
    data.columns = [col if col != "birthYear" else "birth_year" for col in data.columns]
    data.columns = [col if col != "birthMonth" else "birth_month" for col in data.columns]
    data.columns = [col if col != "birthDay" else "birth_day" for col in data.columns]
    data.columns = [col if col != "birthCountry" else "birth_country" for col in data.columns]
    data.columns = [col if col != "birthState" else "birth_state" for col in data.columns]
    data.columns = [col if col != "birthCity" else "birth_city" for col in data.columns]
    data.columns = [col if col != "deathYear" else "death_year" for col in data.columns]
    data.columns = [col if col != "deathMonth" else "death_month" for col in data.columns]
    data.columns = [col if col != "deathDay" else "death_day" for col in data.columns]
    data.columns = [col if col != "deathCountry" else "death_country" for col in data.columns]
    data.columns = [col if col != "deathState" else "death_state" for col in data.columns]
    data.columns = [col if col != "deathCity" else "death_city" for col in data.columns]
    data.columns = [col if col != "nameFirst" else "name_first" for col in data.columns]
    data.columns = [col if col != "nameLast" else "name_last" for col in data.columns]
    data.columns = [col if col != "nameGiven" else "name_given" for col in data.columns]
    data.columns = [col if col != "finalGame" else "final_game" for col in data.columns]
    data.columns = [col if col != "team_idwinner" else "team_id_winner" for col in data.columns]
    data.columns = [col if col != "lg_idwinner" else "lg_id_winner" for col in data.columns]
    data.columns = [col if col != "team_idloser" else "team_id_loser" for col in data.columns]
    data.columns = [col if col != "lg_idloser" else "lg_id_loser" for col in data.columns]
    data.columns = [col if col != "DivWin" else "div_win" for col in data.columns]
    data.columns = [col if col != "WCWin" else "wc_win" for col in data.columns]
    data.columns = [col if col != "LgWin" else "lg_win" for col in data.columns]
    data.columns = [col if col != "WSWin" else "ws_win" for col in data.columns]
    data.columns = [col if col != "franchName" else "franch_name" for col in data.columns]
    data.columns = [col if col != "NAassoc" else "na_assoc" for col in data.columns]
    data.columns = [col.lower() for col in data.columns]

    data.to_csv("output/%s.csv" % tables[table], index=False)
    data = pd.read_csv("output/%s.csv" % tables[table], low_memory=False)

    sql += """CREATE TABLE %s (
%s);
.import "working/no_header/%s.csv" %s

""" % (tables[table],
       ",\n".join(["    %s %s%s" % (key,
                                   conversion[str(data.dtypes[key])],
                                   " PRIMARY KEY" if key=="Id" else "")
                   for key in data.dtypes.keys()]), tables[table], tables[table])

open("src/import.sql", "w").write(sql)
