<template>
    <section>
        <div class="modal-card" style="width: 62em; height: auto">
            <header class="modal-card-head">
                <p class="modal-card-title">{{ modalHeader }}</p>
                <button type="button" class="delete" @click="$emit('close')" />
            </header>
            <section class="modal-card-body" ref="editOffice">
                <b-tabs>
                    <div class="box">
                        <div v-if="office" class="columns is-centered">
                            <div class="column is-centered">
                                <b-tabs type="is-boxed" position="is-centered">

                                    <b-tab-item label="Datos">
                                        <ValidationObserver v-slot="{ handleSubmit }" ref="observer">
                                            <form @submit.prevent="handleSubmit(checkEditData())">

                                        <div class="center">
                                            <h1>Datos de la dependencia</h1>
                                        </div>

                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="Nombre de dependencia">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-input v-model="office.name_office"
                                                        placeholder="Ingrese el nombre del edificio"></b-input>
                                                        <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>



                                        </div>
                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="Ubicación">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-input v-model="office.location"
                                                        placeholder="Ingrese la ubicación de la dependencia (Edificio, en que piso se encuentra..)">
                                                    </b-input>
                                                    <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>
                                        </div>


                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="N° Identificación">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-input v-model="office.identification_number_office"
                                                        placeholder="Ingrese el numero de identificación de la dependencia"
                                                        type="textarea"></b-input>
                                                        <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>
                                            <div class="column">
                                                <b-field label="Identificación administración campus">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-input v-model="office.campus_identification"
                                                        placeholder="Ingrese el numero de identificación de la dependencia"
                                                        type="textarea"></b-input>
                                                        <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>

                                        </div>



                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="Horas semanales disponibles">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-numberinput min="1" max="100" v-model="office.hours_available"
                                                        type="is-info"
                                                        placeholder="Ingrese la cantidad de horas semanales disponibles de la dependencia">
                                                    </b-numberinput>
                                                    <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>
                                            <div class="column">
                                                <b-field label="Metros cuadrados">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-numberinput min="1" max="100" v-model="office.square_meter"
                                                        type="is-info"
                                                        placeholder="Ingrese cuantos metro cuadrados tiene la dependencia">
                                                    </b-numberinput>
                                                    <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>

                                        </div>








                                        <b-field grouped position="is-right">
                                            <p class="control">
                                                <b-button label="Guardar" type="is-info" @click="checkEditData()" />
                                            </p>
                                        </b-field>
                                    </form>
                                        </ValidationObserver>
                                    </b-tab-item>

                                    <b-tab-item label="Cargos">
                                        <ValidationObserver v-slot="{ handleSubmit }" ref="observer">
                                            <form @submit.prevent="handleSubmit(checkCharge())">


                                        <div class="center">
                                            <h1>Designación de la dependencia</h1>
                                        </div>


                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="Unidad">
                                                    <b-input v-model="office.duty_manager.name_unit" type="text"
                                                        readonly>
                                                    </b-input>
                                                </b-field>
                                            </div>

                                            <div class="column">
                                                <b-field label="Edificio">
                                                    <b-input v-model="office.building.name_building" type="text"
                                                        readonly></b-input>
                                                </b-field>
                                            </div>


                                            <div class="column">
                                                <b-field label="Persona encargada">
                                                    <b-input v-model="office.duty_manager.name_duty_manager" type="text"
                                                        readonly></b-input>
                                                </b-field>
                                            </div>
                                        </div>

                                        <div>

                                            <div class="notification">
                                                <div class="content">
                                                    <h1 class="has-text-left">Nueva designación</h1>

                                                    <div class="columns">


                                                        <div class="column">
                                                            <b-field label="Nueva Unidad">
                                                                <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <multiselect v-model="aux_unit_id"
                                                                    :options="units.map((type) => type.id)"
                                                                    :custom-label="
                                                                        (opt) =>
                                                                            units.find((x) => x.id === opt).name_unit
                                                                    " placeholder="Seleccionar Unidad"
                                                                    selectedLabel="Seleccionado" selectLabel=""
                                                                    :allow-empty="true" :disabled="
                                                                        aux_duty_manager_id !== null ||
                                                                        aux_building_id !== null
                                                                    " @input="getdutymanagerbyunit(aux_unit_id);
getbuildingbyunit(aux_unit_id);">
                                                                </multiselect>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                            </b-field>
                                                        </div>


                                                        <div class="column">
                                                            <b-field label="Nueva persona encargada">
                                                                <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <multiselect v-model="aux_duty_manager_id"
                                                                    :options="managers.map((type) => type.id)"
                                                                    :custom-label="
                                                                        (opt) =>
                                                                            managers.find((x) => x.id === opt)
                                                                                .name_duty_manager
                                                                    " placeholder="Seleccionar persona encargada"
                                                                    selectLabel="Presione para seleccionar"
                                                                    selectedLabel="Seleccionado"
                                                                    deselectLabel="Presione para deseleccionar"
                                                                    :allow-empty="true" :disabled="aux_unit_id == null">
                                                                </multiselect>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                            </b-field>
                                                        </div>

                                                        <div class="column">
                                                            <b-field label="Nuevo Edificio">
                                                                <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <multiselect v-model="aux_building_id"
                                                                    :options="buildings.map((type) => type.id)"
                                                                    :custom-label="
                                                                        (opt) =>
                                                                            buildings.find((x) => x.id === opt)
                                                                                .name_building
                                                                    " placeholder="Seleccionar Unidad"
                                                                    selectLabel="Presione para seleccionar"
                                                                    selectedLabel="Seleccionado"
                                                                    deselectLabel="Presione para deseleccionar"
                                                                    :allow-empty="true" :disabled="
                                                                        aux_unit_id == null
                                                                    ">
                                                                </multiselect>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                            </b-field>
                                                        </div>

                                                    </div>


                                                    <b-field grouped position="is-right">
                                                        <p class="control">
                                                            <b-button label="Guardar" type="is-info"
                                                                @click="checkCharge()" />
                                                        </p>
                                                    </b-field>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                        </ValidationObserver>
                                    </b-tab-item>
                                </b-tabs>
                            </div>
                        </div>
                        <div v-else>
                            <p>Loading</p>
                        </div>
                    </div>
                </b-tabs>
            </section>
        </div>
    </section>
</template>


<script>
import axios from "axios";
import IndexOffices from "./index_office.vue";
import moment from "moment";
export default {
    name: "edit_office",
    props: ["queryType", "modalHeader", "officeId", "id"],
    components: {
        "index-office": IndexOffices,
    },

    data() {
        return {
            office: null,
            offices: [],
            props: ["id"],
            units: [],
            managers: [],
            buildings: [],
            aux_unit_id: null,
            aux_building_id: null,
            aux_duty_manager_id: null,
        };
    },
    methods: {
        async getoffice() {
            const response = await axios.get("/offices/" + this.id + ".json");
            this.loading = true;
            this.office = response.data;
        },

        async getunitactive() {
            const response = await axios.get("/units/showactiveunit.json");
            this.units = response.data;
        },

        async getdutymanagerbyunit(item) {
            const response = await axios.get(
                "http://localhost:3000/duty_managers/showdutymanagerunit/" +
                item +
                ".json"
            );
            this.managers = response.data;
        },

        async getbuildingbyunit(item) {
            const response = await axios.get(
                "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
            );
            this.buildings = response.data;
        },

        async getofficebybuilding(item) {
            const response = await axios.get(
                "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
            );
            this.offices = response.data;
        },

        async EditClick() {
            const response = await axios.put("/offices/" + this.id + ".json", {
                name_office: this.office.name_office,
                location: this.office.location,
                identification_number_office: this.office.identification_number_office,
                campus_identification: this.office.campus_identification,
                hours_available: this.office.hours_available,
                square_meter: this.office.square_meter,
            });
            window.location.href = "/offices/" + this.id;
        },

        async checkEditData(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmedit();
    }
    },

        confirmedit() {
            this.$buefy.dialog.confirm({
                title: "Editar la dependencia",
                message: `¿Esta seguro de editar la dependencia?`,
                cancelText: "Cancelar",
                confirmText: "Guardar",
                type: "is-info",
                onConfirm: () => this.EditClick(),
            });
        },
        async EditClickDes() {
            const response = await axios.put("/offices/" + this.id + ".json", {
                duty_manager_id: this.aux_duty_manager_id,
                building_id: this.aux_building_id,
                unit_id: this.aux_unit_id,
                activegood: 1,
            });
            window.location.href = "/offices";
        },

        confirmeditDes() {
            this.$buefy.dialog.confirm({
                title: "Editar la dependencia",
                message: `¿Esta seguro de editar la dependencia?`,
                cancelText: "Cancelar",
                confirmText: "Guardar",
                type: "is-info",
                onConfirm: () => this.EditClickDes(),
            });
        },
        async checkCharge(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmeditDes();
    }
    },
        

        async check() {
            const valid = await this.$refs.observer.validate()
            if (!valid) {
                this.$buefy.dialog.alert(
                    {
                        message: 'Algunos campos presentan errores.', type: 'is-danger',
                        hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true
                    }
                )
            }
            else {
                this.confirmregister();
            }
        },


    },
    created() {
        this.getoffice();
        this.getunitactive();
    },
};
</script>




