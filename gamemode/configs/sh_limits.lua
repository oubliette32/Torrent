/*
 *  Torrent - 2013 Illuminati Productions
 *
 *  This product is licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  
 */

// This file contains limits to certain things, all values in here can be changed at will respecting there effects.


// The max amount of props any one player can have.
TR_MAX_PROPS = 25;

// The amount of props each player in a team can place, for example if this was 10 and there was 4 people on
// A team, that team to collabaratively plce 40 props.  A team's prop limit will never go lower than TR_MAX_PROPS.
TR_TEAM_PROP_COUNT = 10;

// The minimum amount of players that have to be on the server before player's can team with eachother.
// You can never join a team if by joining that team all players on a server are on a single team.
TR_TEAM_PLIMIT = 4;

// The max amount of players per team.
TR_TEAM_LIMIT = 4;

// The max amount of constraints any one player can have.
TR_MAX_CONSTRAINTS = 75;

// Same as TR_TEAM_PROP_COUNT but for constraints instead.
TR_TEAM_CONSTRAINT_COUNT = 20;