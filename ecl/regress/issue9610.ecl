/*##############################################################################

    HPCC SYSTEMS software Copyright (C) 2013 HPCC Systems®.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
############################################################################## */


//Test a very obscue case extracting two identical fields from different records;

aRec := { unsigned a1; unsigned a2; };

bRec := { aRec x; aRec y; };

ds := DATASET('ds', bRec, THOR);

inDs := DATASET('in', bRec, THOR);

sortedDs := SORT(inDs, x.a2); // this will create a child query
ds1 := PROJECT(SORT(ds, x.a1), transform(bRec, SELF.x.a2 := 2; SELF := LEFT))[1];

filtered2 := sortedDs(x.a1 = ds1.x.a1, x.a2 = ds1.y.a1);    // access two fields from ds1 -= both the same
output(filtered2);
