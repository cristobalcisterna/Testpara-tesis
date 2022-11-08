<template>
    <section>

        <div class="modal-card" style="width: 62em; height: auto">
            <header class="modal-card-head">
                <p class="modal-card-title">{{ modalHeader }}</p>
                <button type="button" class="delete" @click="$emit('close')" />
            </header>
            <section class="modal-card-body" ref="editDutyManager">
                <b-tabs>
                    <div class="box">
                        <div v-if="manager" class="columns is-centered">
                            <div class="column is-centered">



                                <b-tabs type="is-boxed" position="is-centered">

                                    <b-tab-item label="Datos">
                                        <ValidationObserver v-slot="{ handleSubmit }" ref="observer">
                                            <form @submit.prevent="handleSubmit(checkEditData())">

                                                <div class="center">
                                                    <h1>Datos del Bien</h1>
                                                </div>

                                                <div class="columns">
                                                    <div class="column">
                                                        <b-field label="Nombre">
                                                            <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-input v-model="manager.name_duty_manager"
                                                                    placeholder="Ingrese el nombre del edificio">
                                                                </b-input>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                        </b-field>
                                                    </div>



                                                </div>
                                                <div class="columns">
                                                    <div class="column">
                                                        <b-field label="RUT">
                                                            <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-input v-model="manager.rut"
                                                                    placeholder="Ingrese el RUT de la persona asociada sin puntos y con guion">
                                                                </b-input>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                        </b-field>
                                                    </div>
                                                </div>

                                                <div class="columns">
                                                    <div class="column">
                                                        <b-field label="Email">
                                                            <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-input v-model="manager.email"
                                                                    placeholder="Ingrese el Email de la persona asociada">
                                                                </b-input>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                        </b-field>
                                                    </div>
                                                </div>

                                                <b-field grouped position="is-right">
                                                    <p class="control">
                                                        <b-button label="Guardar" type="is-info"
                                                            @click="checkEditData()" />
                                                    </p>
                                                </b-field>
                                            </form>
                                        </ValidationObserver>
                                    </b-tab-item>







                                    <b-tab-item label="Cargos">
                                        <ValidationObserver v-slot="{ handleSubmit }" ref="observer">
                                            <form @submit.prevent="handleSubmit(confirmeditDes())">


                                                <div class="center">
                                                    <h1>Designación de la persona</h1>
                                                </div>


                                                <div class="columns">
                                                    <div class="column">
                                                        <b-field label="Unidad">
                                                            <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-input v-model="manager.unit.name_unit" type="text"
                                                                    readonly>
                                                                </b-input>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                        </b-field>
                                                    </div>
                                                </div>

                                                <div class="notification">
                                                    <div class="content">
                                                        <h1 class="has-text-left">Nueva designación</h1>



                                                        <div class="columns">
                                                            <div class="column">
                                                                <b-field label="Nueva Unidad">
                                                                    <ValidationProvider name="Descripción"
                                                                        rules="required" v-slot="{ errors }">
                                                                        <multiselect v-model="aux_unit_id"
                                                                            :options="units.map((type) => type.id)"
                                                                            :custom-label="
                                                                                (opt) =>
                                                                                    units.find((x) => x.id === opt).name_unit
                                                                            " placeholder="Seleccionar Unidad"
                                                                            selectedLabel="Seleccionado" selectLabel=""
                                                                            :allow-empty="true">
                                                                        </multiselect>
                                                                        <span class="validation-alert">{{ errors[0]
                                                                        }}</span>
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
import IndexDutyManager from "./index_duty_manager.vue";
export default {
    name: "edit_duty_manager",
    props: ["queryType", "modalHeader", "duty_managerId", "id"],
    components: {
        "index-duty-manager": IndexDutyManager,
    },

    data() {
        return {
            props: ["id"],
            units: [],
            managers: [],
            manager: null,
            aux_unit_id: null,
        };
    },
    methods: {
        async getmanager() {
            const response = await axios.get("/duty_managers/" + this.id + ".json");
            this.manager = response.data;
            console.log(this.manager);
        },

        async getunitactive() {
            const response = await axios.get("/units/showactiveunit.json");
            this.units = response.data;
        },

        async EditClick() {
            const response = await axios.put("/duty_managers/" + this.id + ".json", {
                name_duty_manager: this.manager.name_duty_manager,
                rut: this.manager.rut,
                email: this.manager.email,
            });
            window.location.href = "/duty_managers/" + this.id;
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
                title: "Editar la información de la persona",
                message: `¿Esta seguro de editar la información de la persona?`,
                cancelText: "Cancelar",
                confirmText: "Guardar",
                type: "is-info",
                onConfirm: () => this.EditClick(),
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
        async EditClickDes() {
            const response = await axios.put("/duty_managers/" + this.id + ".json", {
                unit_id: this.aux_unit_id,
                activegood: 1,
            });
            window.location.href = "/duty_managers";
        },

        confirmeditDes() {
            this.$buefy.dialog.confirm({
                title: "Editar la información de la persona",
                message: `¿Esta seguro de editar la información de la persona?`,
                cancelText: "Cancelar",
                confirmText: "Guardar",
                type: "is-info",
                onConfirm: () => this.EditClickDes(),
            });
        },


    },
    created() {
        this.getmanager();
        this.getunitactive();
    },
};
</script>




